#!/bin/bash

echo "Enabling GDM display manager..."

# Enable GDM display manager for next boot (don't start now)
sudo systemctl enable gdm.service

echo "✓ GDM enabled"
echo "Note: GDM theming will be configured on first boot via first-run.sh"
