#!/bin/bash

ansi_art='
▄▄▄▄  ▄ ▄▄▄▄  ▄  ▄▄▄ ▄▄▄  ▄▄▄▄
█ █ █ ▄ █ █ █ ▄ █   █   █ █   █
█   █ █ █   █ █ █   ▀▄▄▄▀ █   █
      █       █                 '

clear
echo -e "\n$ansi_art\n"
echo "Running first-boot configuration..."
echo

ALGALON_PATH="$HOME/.local/share/algalon"

# Run first-run scripts in order
echo "→ Configuring DNS resolver..."
bash "$ALGALON_PATH/install/first-run/dns-resolver.sh"

echo
echo "→ Configuring firewall..."
bash "$ALGALON_PATH/install/first-run/firewall.sh"

echo
echo "→ Installing GNOME extensions..."
bash "$ALGALON_PATH/install/first-run/gnome-extensions.sh"

echo
echo "→ Configuring GDM login screen..."
bash "$ALGALON_PATH/install/first-run/gdm-config.sh"

echo
echo "→ Setting up GPG for commit signing..."
bash "$ALGALON_PATH/install/first-run/gpg-setup.sh"

echo
echo "→ Showing welcome message..."
bash "$ALGALON_PATH/install/first-run/welcome.sh"

echo
echo "╔═══════════════════════════════════════════════════════════════════╗"
echo "║                   FIRST-RUN COMPLETE                          ║"
echo "╚═══════════════════════════════════════════════════════════════════╝"
echo
echo "You may need to:"
echo "  - Restart GNOME Shell (Alt+F2, type 'r', press Enter)"
echo "  - Or log out and back in for all changes to take effect"
echo
