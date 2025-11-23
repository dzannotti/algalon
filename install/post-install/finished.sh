#!/bin/bash

clear
echo
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                                                                   ║"
echo "║                        ALGALON INSTALLED                          ║"
echo "║                                                                   ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo
echo "Installation completed successfully!"
echo
echo "Next steps:"
echo "  1. Run first-run setup: ~/.local/share/algalon/first-run.sh"
echo "     This will configure:"
echo "     • Firewall (UFW with SSH, Samba, NFS, Tailscale)"
echo "     • DNS resolver (systemd-resolved)"
echo "     • Tailscale VPN"
echo "     • GPG for git commit signing"
echo
echo "  2. Configure homelab Docker stack:"
echo "     cd ~/.local/share/algalon/homelab"
echo "     cp .env.example .env"
echo "     nano .env  # Fill in your credentials"
echo "     sudo systemctl start algalon-homelab"
echo
echo "  3. Optional: Reboot to verify everything starts on boot"
echo
echo "Your Algalon homelab server is ready!"
echo "Access services at *.algalon.local after Pi-hole DNS is configured."
echo
