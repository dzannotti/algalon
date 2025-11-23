#!/bin/bash

echo "Installing wallpapers..."

# Create backgrounds directory
mkdir -p ~/.local/share/backgrounds

# Copy wallpapers from default/backgrounds
if [ -d "$ALGALON_PATH/default/backgrounds" ]; then
  cp -r "$ALGALON_PATH/default/backgrounds"/* ~/.local/share/backgrounds/ 2>/dev/null || true
fi

# Set shaded.png as default wallpaper
WALLPAPER="$HOME/.local/share/backgrounds/shaded.png"
if [ -f "$WALLPAPER" ]; then
  gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
  gsettings set org.gnome.desktop.background picture-uri-dark "file://$WALLPAPER"
  echo "Wallpaper set to shaded.png"
else
  echo "Warning: shaded.png not found"
fi
