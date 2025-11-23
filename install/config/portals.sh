# Configure XDG Desktop Portals for screen sharing
# Required for Zoom, Discord, Meet, etc. on Wayland

echo "Configuring XDG Desktop Portals for screen sharing..."

# Create portal configuration directory
mkdir -p ~/.config/xdg-desktop-portal

# Configure portals to use GNOME backend
cat > ~/.config/xdg-desktop-portal/portals.conf <<EOF
[preferred]
default=gnome;gtk
org.freedesktop.impl.portal.ScreenCast=gnome
org.freedesktop.impl.portal.Screenshot=gnome
EOF

# Create GNOME-specific portal config
mkdir -p ~/.config/xdg-desktop-portal-gnome

# Ensure portals service is enabled
systemctl --user enable xdg-desktop-portal-gnome.service
systemctl --user enable xdg-desktop-portal-gtk.service
systemctl --user enable xdg-desktop-portal.service

echo "XDG Desktop Portals configured for screen sharing"
echo "Apps like Zoom, Discord, and Meet should now work properly"
