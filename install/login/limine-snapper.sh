# Configure Limine bootloader with Snapper snapshot integration
# This allows booting into previous system snapshots from the boot menu

# Check if limine bootloader is actually installed and configured
if [[ -f /boot/EFI/limine/limine.conf ]] || [[ -f /boot/EFI/BOOT/limine.conf ]] || [[ -f /boot/limine/limine.conf ]]; then
  echo "Limine bootloader detected, configuring Snapper integration..."

  # Only install limine packages if we have limine (these are AUR packages, use yay)
  if ! yay -S --noconfirm --needed limine-snapper-sync limine-mkinitcpio-hook 2>/dev/null; then
    echo "Warning: Could not install limine packages, skipping bootloader configuration"
    return 0
  fi

  # Verify packages installed correctly
  if ! command -v limine-update &>/dev/null; then
    echo "Warning: limine-update not available, skipping bootloader configuration"
    return 0
  fi

  sudo tee /etc/mkinitcpio.conf.d/algalon_hooks.conf <<EOF >/dev/null
HOOKS=(base udev keyboard autodetect microcode modconf kms keymap consolefont block encrypt filesystems fsck btrfs-overlayfs)
EOF

  [[ -f /boot/EFI/limine/limine.conf ]] || [[ -f /boot/EFI/BOOT/limine.conf ]] && EFI=true

  # Conf location is different between EFI and BIOS
  if [[ -n "$EFI" ]]; then
    # Check USB location first, then regular EFI location
    if [[ -f /boot/EFI/BOOT/limine.conf ]]; then
      limine_config="/boot/EFI/BOOT/limine.conf"
    else
      limine_config="/boot/EFI/limine/limine.conf"
    fi
  else
    limine_config="/boot/limine/limine.conf"
  fi

  # Double-check and exit gracefully if we don't have a config file
  if [[ ! -f $limine_config ]]; then
    echo "Warning: Limine config not found at $limine_config, skipping configuration"
    return 0
  fi

  CMDLINE=$(grep "^[[:space:]]*cmdline:" "$limine_config" | head -1 | sed 's/^[[:space:]]*cmdline:[[:space:]]*//')

  sudo tee /etc/default/limine <<EOF >/dev/null
TARGET_OS_NAME="Algalon"

ESP_PATH="/boot"

KERNEL_CMDLINE[default]="$CMDLINE"
KERNEL_CMDLINE[default]+="quiet splash"

ENABLE_UKI=yes
CUSTOM_UKI_NAME="algalon"

ENABLE_LIMINE_FALLBACK=yes

# Find and add other bootloaders
FIND_BOOTLOADERS=yes

BOOT_ORDER="*, *fallback, Snapshots"

MAX_SNAPSHOT_ENTRIES=5

SNAPSHOT_FORMAT_CHOICE=5
EOF

  # UKI and EFI fallback are EFI only
  if [[ -z $EFI ]]; then
    sudo sed -i '/^ENABLE_UKI=/d; /^ENABLE_LIMINE_FALLBACK=/d' /etc/default/limine
  fi

  # Clean up any orphaned limine-update temp directories before proceeding
  sudo find /boot -maxdepth 1 -type d -name '[0-9a-f]*' -exec rm -rf {} + 2>/dev/null || true

  # Check available space in /boot (need at least 300MB for UKI generation)
  BOOT_AVAIL_MB=$(df -BM /boot | awk 'NR==2 {print $4}' | sed 's/M//')
  if [[ $BOOT_AVAIL_MB -lt 300 ]]; then
    echo "Error: Not enough space in /boot partition ($BOOT_AVAIL_MB MB available, need 300MB)"
    echo "Current /boot usage:"
    du -sh /boot/* 2>/dev/null | sort -h
    return 1
  fi

  # Back up existing limine.conf before overwriting
  if [[ -f /boot/limine.conf ]]; then
    sudo cp /boot/limine.conf /boot/limine.conf.backup
  fi

  # We overwrite the whole thing knowing the limine-update will add the entries for us
  sudo tee /boot/limine.conf <<EOF >/dev/null
### Read more at config document: https://github.com/limine-bootloader/limine/blob/trunk/CONFIG.md
#timeout: 3
default_entry: 2
interface_branding: Algalon Bootloader
interface_branding_color: 2
hash_mismatch_panic: no

term_background: 1a1b26
backdrop: 1a1b26

# Terminal colors (Tokyo Night palette)
term_palette: 15161e;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;7dcfff;a9b1d6
term_palette_bright: 414868;f7768e;9ece6a;e0af68;7aa2f7;bb9af7;7dcfff;c0caf5

# Text colors
term_foreground: c0caf5
term_foreground_bright: c0caf5
term_background_bright: 24283b

EOF

  # Match Snapper configs if not installing from the ISO
  if [[ -z ${ALGALON_CHROOT_INSTALL:-} ]]; then
    if ! sudo snapper list-configs 2>/dev/null | grep -q "root"; then
      sudo snapper -c root create-config /
    fi

    if ! sudo snapper list-configs 2>/dev/null | grep -q "home"; then
      sudo snapper -c home create-config /home
    fi
  fi

  # Tweak default Snapper configs
  sudo sed -i 's/^TIMELINE_CREATE="yes"/TIMELINE_CREATE="no"/' /etc/snapper/configs/{root,home}
  sudo sed -i 's/^NUMBER_LIMIT="50"/NUMBER_LIMIT="5"/' /etc/snapper/configs/{root,home}
  sudo sed -i 's/^NUMBER_LIMIT_IMPORTANT="10"/NUMBER_LIMIT_IMPORTANT="5"/' /etc/snapper/configs/{root,home}

  sudo systemctl enable limine-snapper-sync.service

  echo "Re-enabling mkinitcpio hooks..."

  # Restore the specific mkinitcpio pacman hooks
  if [ -f /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled ]; then
    sudo mv /usr/share/libalpm/hooks/90-mkinitcpio-install.hook.disabled /usr/share/libalpm/hooks/90-mkinitcpio-install.hook
  fi

  if [ -f /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled ]; then
    sudo mv /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook.disabled /usr/share/libalpm/hooks/60-mkinitcpio-remove.hook
  fi

  echo "mkinitcpio hooks re-enabled"

  echo "Running limine-update (this may take a minute)..."
  if ! sudo limine-update; then
    echo "Error: limine-update failed"
    # Restore backup if limine-update failed
    if [[ -f /boot/limine.conf.backup ]]; then
      echo "Restoring previous limine.conf..."
      sudo cp /boot/limine.conf.backup /boot/limine.conf
    fi
    return 1
  fi

  # Verify boot entries were actually created
  if ! grep -q "^:Algalon" /boot/limine.conf 2>/dev/null; then
    echo "Warning: limine-update succeeded but no boot entries found in limine.conf"
    echo "Check /boot/limine.conf manually"
  fi

  if [[ -n $EFI ]] && efibootmgr &>/dev/null; then
    # Remove the archinstall-created Limine entry
    while IFS= read -r bootnum; do
      sudo efibootmgr -b "$bootnum" -B >/dev/null 2>&1
    done < <(efibootmgr | grep -E "^Boot[0-9]{4}\*? Arch Linux Limine" | sed 's/^Boot\([0-9]\{4\}\).*/\1/')
  fi

  echo "Limine bootloader configured with Snapper integration"
else
  echo "Limine bootloader not detected, skipping snapshot configuration"
  echo "(This is normal if you're using GRUB or systemd-boot)"
fi
