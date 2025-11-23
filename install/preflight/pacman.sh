#!/bin/bash

# Install build tools and reflector
sudo pacman -S --needed --noconfirm base-devel git openssh reflector

# Configure pacman
sudo cp -f "$ALGALON_PATH/default/pacman/pacman.conf" /etc/pacman.conf

# Copy our mirrorlist (includes cache proxy at top for VM testing)
sudo cp -f "$ALGALON_PATH/default/pacman/mirrorlist" /etc/pacman.d/mirrorlist

# Refresh all repos
sudo pacman -Syu --noconfirm
