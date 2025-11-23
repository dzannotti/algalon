#!/bin/bash

# Install custom fonts from default/fonts

echo "Installing custom fonts..."

# Create user fonts directory
mkdir -p ~/.local/share/fonts

# Copy all fonts from default/fonts
if [ -d "$ALGALON_PATH/default/fonts" ]; then
  cp -r "$ALGALON_PATH/default/fonts"/* ~/.local/share/fonts/
  
  # Update font cache
  fc-cache -f ~/.local/share/fonts
  
  echo "Custom fonts installed"
else
  echo "No custom fonts found, skipping"
fi
