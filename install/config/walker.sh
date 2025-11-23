#!/bin/bash

echo "Configuring Walker launcher..."

# Copy walker launch scripts to ~/.local/bin
mkdir -p ~/.local/bin
cp "$ALGALON_PATH/bin/algalon-launch-walker" ~/.local/bin/
cp "$ALGALON_PATH/bin/algalon-restart-walker" ~/.local/bin/
chmod +x ~/.local/bin/algalon-launch-walker
chmod +x ~/.local/bin/algalon-restart-walker

# Create pacman hook to restart walker/elephant after updates
sudo mkdir -p /etc/pacman.d/hooks
sudo tee /etc/pacman.d/hooks/walker-restart.hook > /dev/null << 'HOOK_EOF'
[Trigger]
Type = Package
Operation = Install
Operation = Upgrade
Operation = Remove
Target = walker
Target = elephant*

[Action]
Description = Restarting Walker and Elephant services
When = PostTransaction
Exec = /home/$USER/.local/bin/algalon-restart-walker
HOOK_EOF

echo "Walker launch scripts and pacman hook configured"
