#!/bin/bash

# Fix Chrome crashing on launch due to broken Wayland auto-detection
# Force Chrome to use Wayland explicitly instead of trying to auto-detect

if command -v google-chrome-stable &>/dev/null; then
  echo "Configuring Chrome to use Wayland explicitly..."

  # Create local override of Chrome desktop files
  mkdir -p ~/.local/share/applications

  # Override the main Chrome launcher
  if [[ -f /usr/share/applications/google-chrome.desktop ]]; then
    cp /usr/share/applications/google-chrome.desktop ~/.local/share/applications/
    sed -i 's|^Exec=/usr/bin/google-chrome-stable|Exec=/usr/bin/google-chrome-stable --ozone-platform=wayland|g' ~/.local/share/applications/google-chrome.desktop
  fi

  echo "Chrome configured to use Wayland platform"
else
  echo "Chrome not installed, skipping configuration"
fi
