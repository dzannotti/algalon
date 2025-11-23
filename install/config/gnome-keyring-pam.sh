#!/bin/bash

# Configure PAM to auto-start gnome-keyring on login
# This ensures Chrome sync and other apps can access the system keyring

echo "Configuring PAM to auto-start gnome-keyring..."

# Check if gnome-keyring is installed
if ! pacman -Q gnome-keyring &>/dev/null; then
  echo "gnome-keyring not installed, skipping PAM configuration"
  return 0
fi

# Add gnome-keyring PAM module to GDM if not already present
if ! grep -q "pam_gnome_keyring.so" /etc/pam.d/gdm-password; then
  echo "Adding gnome-keyring to GDM PAM configuration..."

  # Add to auth stack (unlock keyring on login)
  sudo sed -i '/^auth.*pam_unix.so/a auth       optional     pam_gnome_keyring.so' /etc/pam.d/gdm-password

  # Add to session stack (start keyring daemon)
  sudo sed -i '/^session.*pam_unix.so/a session    optional     pam_gnome_keyring.so auto_start' /etc/pam.d/gdm-password

  echo "gnome-keyring PAM configuration added"
else
  echo "gnome-keyring PAM already configured"
fi

echo "gnome-keyring will auto-start on next login"
