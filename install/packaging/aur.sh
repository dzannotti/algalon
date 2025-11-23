#!/bin/bash

# Install AUR packages via yay
echo "Installing AUR packages via yay..."

# Check if yay is installed
if ! command -v yay &> /dev/null; then
    echo "ERROR: yay is not installed. Please run the preflight scripts first."
    exit 1
fi

# Read package list
mapfile -t packages < <(grep -v '^#' "$ALGALON_INSTALL/algalon-aur.packages" | grep -v '^$')

if [ ${#packages[@]} -eq 0 ]; then
    echo "No AUR packages to install"
    exit 0
fi

echo "Found ${#packages[@]} packages to install from AUR"

# Track failures
failed_packages=()

# Install packages one by one to avoid silent failures
for package in "${packages[@]}"; do
    # Skip yay itself if it's already installed
    if [ "$package" = "yay" ] && command -v yay &> /dev/null; then
        echo "Installing $package... ✓ (already installed)"
        continue
    fi

    echo -n "Installing $package... "
    if yay -S --noconfirm --needed "$package" &>/tmp/algalon-aur-$package.log; then
        echo "✓"
    else
        echo "✗ FAILED"
        failed_packages+=("$package")
        echo "  Error log: /tmp/algalon-aur-$package.log"
    fi
done

# Report results
echo ""
echo "════════════════════════════════════════════════════════════════"
if [ ${#failed_packages[@]} -eq 0 ]; then
    echo "✓ All AUR packages installed successfully!"
else
    echo "✗ ${#failed_packages[@]} package(s) failed to install:"
    printf '  - %s\n' "${failed_packages[@]}"
    echo ""
    echo "Check log files in /tmp/algalon-aur-*.log for details"
    echo ""
    echo "You can retry failed packages manually with:"
    echo "  yay -S ${failed_packages[*]}"
fi
echo "════════════════════════════════════════════════════════════════"
echo ""
