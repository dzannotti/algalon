#!/bin/bash
# Configuration phase - set up system and user configs

# Shell setup
source "$ALGALON_INSTALL/config/zsh.sh"

# Hardware configuration
source "$ALGALON_INSTALL/config/hardware/bluetooth.sh"
source "$ALGALON_INSTALL/config/hardware/network.sh"
source "$ALGALON_INSTALL/config/hardware/set-wireless-regdom.sh"
source "$ALGALON_INSTALL/config/hardware/usb-autosuspend.sh"
source "$ALGALON_INSTALL/config/hardware/fix-f13-amd-audio-input.sh"

# System configuration
source "$ALGALON_INSTALL/config/config.sh"
source "$ALGALON_INSTALL/config/gpg.sh"
source "$ALGALON_INSTALL/config/timezones.sh"
source "$ALGALON_INSTALL/config/fast-shutdown.sh"
source "$ALGALON_INSTALL/config/increase-sudo-tries.sh"
source "$ALGALON_INSTALL/config/increase-lockout-limit.sh"
source "$ALGALON_INSTALL/config/ssh-flakiness.sh"
source "$ALGALON_INSTALL/config/localdb.sh"

# Development tools
source "$ALGALON_INSTALL/config/tmux.sh"

# Docker & Homelab
source "$ALGALON_INSTALL/config/docker.sh"
