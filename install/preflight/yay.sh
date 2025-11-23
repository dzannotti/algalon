#!/bin/bash

if command -v yay &> /dev/null; then
    echo "yay already installed"
    return
fi

echo "Installing yay AUR helper..."

sudo pacman -S --needed --noconfirm git

git clone https://aur.archlinux.org/yay.git /tmp/yay
cd /tmp/yay
makepkg -si --noconfirm
cd -
rm -rf /tmp/yay

echo "yay installed successfully"
