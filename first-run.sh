#!/bin/bash

ansi_art='
▄▄▄▄  ▄ ▄▄▄▄  ▄  ▄▄▄ ▄▄▄  ▄▄▄▄
█ █ █ ▄ █ █ █ ▄ █   █   █ █   █
█   █ █ █   █ █ █   ▀▄▄▄▀ █   █
      █       █                 '

clear
echo -e "\n$ansi_art\n"
echo "Running post-installation configuration..."
echo

ALGALON_PATH="$HOME/.local/share/algalon"

# Run first-run scripts in order
echo "→ Configuring DNS resolver..."
bash "$ALGALON_PATH/install/first-run/dns-resolver.sh"

echo
echo "→ Configuring firewall..."
bash "$ALGALON_PATH/install/first-run/firewall.sh"

echo
echo "→ Setting up GPG for commit signing..."
bash "$ALGALON_PATH/install/first-run/gpg-setup.sh"

echo
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                   POST-INSTALL COMPLETE                          ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo
echo "Server configured with:"
echo "  ✓ DNS resolver (systemd-resolved)"
echo "  ✓ Firewall (UFW with SSH, Samba, NFS, Tailscale)"
echo "  ✓ GPG commit signing"
echo
echo "Next steps:"
echo "  - Configure Tailscale: sudo tailscale up"
echo "  - Set up Docker containers for media stack"
echo "  - Configure Samba shares"
echo
