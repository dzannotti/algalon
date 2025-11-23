#!/bin/bash

# Update Algalon configuration
# Pulls latest changes from git and re-applies dotfiles/config

set -e

ALGALON_PATH="$HOME/.local/share/algalon"

cd "$ALGALON_PATH"

echo "Updating Algalon..."
echo

# Pull latest changes
echo "→ Pulling latest changes from git..."
git pull

echo
echo "→ Updating dotfiles and configuration..."

# Re-copy dotfiles from config/ to ~/.config
mkdir -p ~/.config
cp -R "$ALGALON_PATH/config/"* ~/.config

# Ensure autostart file is updated
mkdir -p "$HOME/.config/autostart"
cp -f "$ALGALON_PATH/config/autostart/algalon-first-run.desktop" "$HOME/.config/autostart/"

# Re-apply zsh configuration
if [ -d "$ALGALON_PATH/config/zsh" ]; then
  echo "→ Updating zsh configuration..."
  cp -R "$ALGALON_PATH/config/zsh/"* ~/.config/zsh/
fi

# Update default system files (requires sudo)
echo
echo "→ Updating system defaults (requires sudo)..."

# GPG configuration
if [ -d "$ALGALON_PATH/default/gpg" ]; then
  sudo cp -R "$ALGALON_PATH/default/gpg/"* /etc/
fi

# Zsh system default
if [ -f "$ALGALON_PATH/default/zshrc" ]; then
  sudo cp "$ALGALON_PATH/default/zshrc" /etc/zsh/zshrc
fi

echo
echo "✓ Algalon configuration updated!"
echo
echo "Note: Some changes may require:"
echo "  - Restarting your terminal (for shell changes)"
echo "  - Logging out and back in (for GNOME settings)"
echo "  - Reloading GNOME Shell (Alt+F2, type 'r', press Enter)"
echo
