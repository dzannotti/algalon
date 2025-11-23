#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -eEo pipefail

# Prompt for sudo password once and cache credentials
sudo -v

source "$ALGALON_INSTALL/preflight/all.sh"
source "$ALGALON_INSTALL/packaging/all.sh"
source "$ALGALON_INSTALL/config/all.sh"
source "$ALGALON_INSTALL/login/all.sh"
source "$ALGALON_INSTALL/post-install/all.sh"
