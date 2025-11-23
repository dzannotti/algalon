#!/bin/bash

echo "Configuring GDM login screen..."

# Create dconf directories if they don't exist
echo "→ Creating dconf directories..."
sudo mkdir -p /etc/dconf/db/gdm.d
sudo mkdir -p /etc/dconf/profile

# Copy GDM dconf configuration
echo "→ Installing GDM dconf settings..."
sudo cp "$HOME/.local/share/algalon/default/gnome/gdm-dconf" /etc/dconf/db/gdm.d/01-algalon
sudo cp "$HOME/.local/share/algalon/default/gnome/gdm-profile" /etc/dconf/profile/gdm

# Create backgrounds directory and copy wallpaper for GDM
echo "→ Installing GDM background..."
sudo mkdir -p /usr/share/backgrounds/algalon
sudo cp "$HOME/.local/share/algalon/default/backgrounds/shaded.png" /usr/share/backgrounds/algalon/

# Copy and resize Catppuccin logo for GDM (256x256 for good visibility)
echo "→ Installing GDM logo..."
if command -v convert &> /dev/null; then
  # Resize to 256x256 using ImageMagick
  sudo convert "$HOME/.local/share/algalon/default/logos/catppuccin-logo.png" -resize 256x256 /usr/share/pixmaps/algalon-logo.png
  echo "  Resized Catppuccin logo to 256x256"
elif command -v magick &> /dev/null; then
  # Try new ImageMagick command name
  sudo magick "$HOME/.local/share/algalon/default/logos/catppuccin-logo.png" -resize 256x256 /usr/share/pixmaps/algalon-logo.png
  echo "  Resized Catppuccin logo to 256x256"
else
  # Fallback: just copy and hope GDM scales it (it won't, but we try)
  sudo cp "$HOME/.local/share/algalon/default/logos/catppuccin-logo.png" /usr/share/pixmaps/algalon-logo.png
  echo "  Warning: ImageMagick not found, logo may be too large"
  echo "  Install imagemagick package and re-run for proper sizing"
fi

# Compile dconf database for GDM
echo "→ Compiling dconf database..."
sudo dconf update

# Create dconf directories for gdm user with proper permissions
sudo mkdir -p /var/lib/gdm/.cache/dconf
sudo mkdir -p /var/lib/gdm/.config/dconf
sudo chown -R gdm:gdm /var/lib/gdm/.cache
sudo chown -R gdm:gdm /var/lib/gdm/.config
sudo chmod 700 /var/lib/gdm/.cache/dconf
sudo chmod 700 /var/lib/gdm/.config/dconf

echo "✓ GDM login screen configured"
echo "  Color scheme: Dark with purple accent (Catppuccin Mocha colors)"
echo "  Background: shaded.png"
echo "  Logo: Catppuccin (resized to 256x256)"
echo ""
echo "Note: Using default GDM theme with Catppuccin styling"
echo "      Changes will take effect after reboot or restarting GDM"
