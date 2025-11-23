#!/bin/bash

# Install NvChad configuration

echo "Installing NvChad..."

# Remove existing nvim config if it exists
if [ -d ~/.config/nvim ]; then
	echo "  Removing existing nvim config..."
	rm -rf ~/.config/nvim
fi

# Clone NvChad starter
git clone https://github.com/NvChad/starter ~/.config/nvim
rm -rf ~/.config/nvim/.git
echo "  ✓ NvChad starter cloned"

# Copy our custom overrides (if any exist)
echo "Applying custom nvim configuration..."
cp -r "$ALGALON_PATH/config/nvim/lua"/* ~/.config/nvim/lua/
echo "  ✓ Custom config applied"

echo "NvChad configuration installed"
echo "Plugins will be installed automatically when you first run 'nvim'"
