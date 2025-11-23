#!/bin/bash

# Install GNOME extensions using gnome-extensions-cli (gext)
# Ensure pipx path is available
export PATH="$HOME/.local/bin:$PATH"

# First install gext if not present
if ! command -v gext &> /dev/null; then
    pipx install gnome-extensions-cli --system-site-packages
fi

# Enable extension installation
gsettings set org.gnome.shell disable-user-extensions false

# Install extensions from extensions.gnome.org
echo "Installing GNOME extensions..."

gext install user-theme@gnome-shell-extensions.gcampax.github.com
gext install Vitals@CoreCoding.com
gext install arcmenu@arcmenu.com
gext install blur-my-shell@aunetx
gext install burn-my-windows@schneegans.github.com
gext install caffeine@patapon.info
gext install clipboard-indicator@tudmotu.com
gext install compiz-windows-effect@hermes83.github.com
gext install dash-to-dock@micxgx.gmail.com
gext install desktop-cube@schneegans.github.com
gext install emoji-copy@felipeftn
gext install extension-list@tu.berry
gext install flypie@schneegans.github.com
gext install gtk4-ding@smedius.gitlab.com
gext install just-perfection-desktop@just-perfection
gext install openweather-extension@penguin-teal.github.io
gext install space-bar@luchrioh
gext install window-commander@gnikolaos.gr

echo "GNOME extensions installed. They will be available after logging into GNOME."
echo "You can enable/disable them using Extension Manager."
