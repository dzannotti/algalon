#!/bin/bash

# Configure GNOME appearance with Adwaita and custom icons/cursor

echo "Configuring GNOME appearance..."

# Use default Adwaita theme (no custom GTK theme)
# Adwaita is maintained by GNOME and never breaks on updates

# Set color scheme to prefer dark
gsettings set org.gnome.desktop.interface color-scheme "prefer-dark"

# Set accent color to purple (lavender-like)
gsettings set org.gnome.desktop.interface accent-color "purple"

# Set Qogir-dark icon theme
gsettings set org.gnome.desktop.interface icon-theme 'Qogir-dark'

# Set Qogir cursor theme
gsettings set org.gnome.desktop.interface cursor-theme 'Qogir'

# Set fonts
gsettings set org.gnome.desktop.interface font-name 'Ubuntu Sans 11'
gsettings set org.gnome.desktop.interface document-font-name 'Sans 11'
gsettings set org.gnome.desktop.interface monospace-font-name 'Ubuntu Sans Mono 11'
gsettings set org.gnome.desktop.interface font-antialiasing 'rgba'
gsettings set org.gnome.desktop.interface font-hinting 'slight'

echo "GNOME appearance configured with Adwaita + purple accent"
