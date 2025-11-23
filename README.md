# Algalon

Opinionated Arch Linux configuration focused on GNOME desktop and modern development workflows.

## Installation

### Prerequisites
Fresh Arch Linux installation with:
- Base packages (default)
- User account created (non-root)
- `networkmanager` installed
- Working internet connection

### Connect to Internet (if WiFi)

After fresh Arch install, you'll be in a TTY terminal. Connect to WiFi:

```bash
# Start NetworkManager service
sudo systemctl start NetworkManager

# Connect to WiFi using nmtui (Text UI)
nmtui

# Or use nmcli (command line)
nmcli device wifi list
nmcli device wifi connect "YOUR_SSID" password "YOUR_PASSWORD"

# Verify connection
ping -c 3 archlinux.org
```

**Ethernet:** Should work automatically if NetworkManager is running.

### Quick Start

```bash
# Clone to expected location
git clone https://github.com/dzannotti/algalon.git ~/.local/share/algalon

# Run bootstrap
source ~/.local/share/algalon/boot.sh
```

After installation completes, reboot into GNOME.

### Post-Install (First boot into GNOME)

After logging into GNOME for the first time, run:

```bash
# Run first-boot configuration
~/.local/share/algalon/first-run.sh
```

This will:
- Configure DNS resolver
- Set up firewall
- Install and enable GNOME extensions
- Set up GPG key for commit signing
- Show welcome notifications

You may need to restart GNOME Shell (Alt+F2, type 'r') or log out/in for all changes to take effect.

### Updating Configuration

To update your Algalon configuration after changes to the repo:

```bash
# Pull latest changes and re-apply dotfiles/config
algalon-update
```

This will:
- Pull latest changes from git
- Re-copy all dotfiles to ~/.config
- Update system defaults (zsh, gpg)
- Preserve your local customizations
- Automatically clean up old snapshots (keeps 10 newest)

### Running Individual Setup Components

If you need to re-run a specific setup component (e.g., after importing GPG keys):

```bash
# Run a specific component
algalon-apply gpg-setup

# Available components:
algalon-apply dns-resolver      # Configure systemd-resolved DNS
algalon-apply firewall          # Set up UFW firewall
algalon-apply gnome-extensions  # Install GNOME extensions
algalon-apply gdm-config        # Configure GDM login screen
algalon-apply gpg-setup         # Configure GPG for commit signing
algalon-apply all               # Run all components (same as first-run.sh)
```

This is useful when:
- Testing individual setup scripts
- Applying specific configs without re-running entire first-run
- Setting up GPG after importing your keys on a fresh install

## Philosophy

Inspired by [omarchy](https://github.com/basecamp/omarchy)'s principles but tailored for GNOME users who want:
- Ubuntu-quality defaults and polish on Arch
- Minimal configuration overhead (no tiling WM)
- Quick recovery from system issues
- Repeatable, version-controlled setup

Perfect for ultrawide monitor users who prefer traditional desktop paradigms.

## What's Included

### Desktop Environment
- **GNOME** - Full desktop environment with Ubuntu-like defaults
- **Catppuccin theme** - Consistent theming across all applications

### Development Tools
- **VSCode** - Primary editor with extensions and settings
- **Neovim** - Terminal editor with full configuration
- **Development runtimes** - Installed via native packages
  - Node.js & npm & pnpm
  - Bun
  - Go
  - Rust & Cargo

### Configuration
- Shell configuration and aliases
- Git configuration
- Application preferences and dotfiles

### Keyboard Shortcuts

Global run-or-raise shortcuts for quick application switching (via [run-or-raise](https://github.com/CZ-NIC/run-or-raise) GNOME extension):

- **Ctrl+Alt+J** - Chrome (focus or launch)
- **Ctrl+Alt+H** - Obsidian (focus or launch)
- **Ctrl+Alt+K** - VSCode (focus or launch)
- **Ctrl+Alt+L** - Ghostty terminal (focus or launch)
- **Ctrl+Alt+;** - Ferdium (focus or launch)

Configuration file: `~/.config/run-or-raise/shortcuts.conf`

## Goals

Transform a minimal Arch installation into a fully configured development environment with:
- Production-ready tooling
- Consistent theming
- Sensible defaults
- Zero manual configuration steps

## Notes

This is a personal configuration primarily for my own use. It's public for my own reference and in case the approach is useful to others, but it's not designed as a general-purpose installer.

