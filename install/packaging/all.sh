#!/bin/bash

# Install packages in order: official repos first, then AUR
source "$ALGALON_INSTALL/packaging/pacman.sh"
source "$ALGALON_INSTALL/packaging/aur.sh"
source "$ALGALON_INSTALL/packaging/reflector.sh"
