# Configure GNOME keyboard shortcuts for application launching
# Using Ctrl+Alt+<key> workflow

echo "Configuring custom keyboard shortcuts..."

# GNOME allows custom keybindings via org.gnome.settings-daemon.plugins.media-keys.custom-keybindings
# We need to create custom keybinding entries

# Define the custom keybindings path
CUSTOM_KEYBINDINGS_PATH="/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings"

# Set the list of custom keybindings (removed custom6, now using GNOME's native screenshot binding)
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings \
  "['${CUSTOM_KEYBINDINGS_PATH}/custom0/', '${CUSTOM_KEYBINDINGS_PATH}/custom1/', '${CUSTOM_KEYBINDINGS_PATH}/custom2/', '${CUSTOM_KEYBINDINGS_PATH}/custom3/', '${CUSTOM_KEYBINDINGS_PATH}/custom4/', '${CUSTOM_KEYBINDINGS_PATH}/custom5/', '${CUSTOM_KEYBINDINGS_PATH}/custom7/']"

# Custom0: Ctrl+Space - Walker launcher
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom0/ name "Walker"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom0/ command "$HOME/.local/bin/algalon-launch-walker"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom0/ binding "<Primary>space"

# Custom1: Ctrl+Alt+H - Obsidian (launch or focus)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom1/ name "Obsidian"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom1/ command "$HOME/.local/share/algalon/bin/algalon-launch-or-focus obsidian"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom1/ binding "<Primary><Alt>h"

# Custom2: Ctrl+Alt+J - Chrome (launch or focus)
# Force X11 backend so wmctrl can see and focus Chrome windows
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom2/ name "Chrome"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom2/ command "$HOME/.local/share/algalon/bin/algalon-launch-or-focus chrome 'google-chrome-stable --ozone-platform=x11'"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom2/ binding "<Primary><Alt>j"

# Custom3: Ctrl+Alt+K - VSCode (launch or focus)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom3/ name "VSCode"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom3/ command "$HOME/.local/share/algalon/bin/algalon-launch-or-focus code"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom3/ binding "<Primary><Alt>k"

# Custom4: Ctrl+Alt+L - Ghostty terminal (launch or focus)
# Note: Ghostty on Wayland not visible to wmctrl, won't auto-focus but prevents duplicates
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom4/ name "Ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom4/ command "$HOME/.local/share/algalon/bin/algalon-launch-or-focus ghostty"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom4/ binding "<Primary><Alt>l"

# Custom5: Ctrl+Alt+; - Ferdium (launch or focus)
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom5/ name "Ferdium"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom5/ command "$HOME/.local/share/algalon/bin/algalon-launch-or-focus ferdium"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom5/ binding "<Primary><Alt>semicolon"

# Ctrl+Shift+4 - Use GNOME's built-in screenshot UI (same as Print Screen)
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['Print', '<Primary><Shift>4']"

# Custom7: Ctrl+Shift+F11 - Toggle audio output between A50 and speakers
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom7/ name "Audio Toggle"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom7/ command "$HOME/.local/share/algalon/bin/audio-toggle"
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:${CUSTOM_KEYBINDINGS_PATH}/custom7/ binding "<Primary><Shift>F11"

echo "Custom keyboard shortcuts configured:"
echo "  Ctrl+Space     → Walker"
echo "  Ctrl+Alt+H     → Obsidian (launch or focus)"
echo "  Ctrl+Alt+J     → Chrome (launch or focus)"
echo "  Ctrl+Alt+K     → VSCode (launch or focus)"
echo "  Ctrl+Alt+L     → Ghostty (launch or focus)"
echo "  Ctrl+Alt+;     → Ferdium (launch or focus)"
echo "  Ctrl+Shift+4   → GNOME Screenshot UI (same as Print Screen)"
echo "  Ctrl+Shift+F11 → Toggle audio output (A50 ↔ Speakers)"
