#!/bin/bash

# Disable GNOME Tour from auto-launching on first login
mkdir -p ~/.config/autostart
cat > ~/.config/autostart/gnome-tour.desktop << 'DESKTOP_EOF'
[Desktop Entry]
Type=Application
Name=GNOME Tour
Exec=true
Hidden=true
NoDisplay=true
X-GNOME-Autostart-enabled=false
DESKTOP_EOF

# Also mark initial setup as complete
mkdir -p ~/.config
touch ~/.config/gnome-initial-setup-done
