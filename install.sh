#!/bin/bash

# Prompt for sudo password once and cache credentials
sudo -v

# Note: Not using set -e because some hardware detection scripts
# may fail gracefully (e.g., nvidia on non-nvidia systems)

source "$ALGALON_INSTALL/preflight/all.sh"
source "$ALGALON_INSTALL/packaging/all.sh"
source "$ALGALON_INSTALL/config/all.sh"
source "$ALGALON_INSTALL/login/all.sh"
source "$ALGALON_INSTALL/post-install/all.sh"
