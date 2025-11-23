#!/bin/bash
# GPG Setup for commit signing
# Configures git to use existing GPG key or guides setup

set -euo pipefail

USER_EMAIL="${GIT_EMAIL:-dzannotti@me.com}"
USER_NAME="${GIT_NAME:-dzannotti}"

echo "Setting up GPG for commit signing..."
echo

# Check if any GPG secret key exists
if gpg --list-secret-keys --keyid-format=long 2>/dev/null | grep -q "^sec"; then
    # Keys exist - find the right one
    if gpg --list-secret-keys --keyid-format=long "$USER_EMAIL" &>/dev/null; then
        # Key exists for this email
        KEY_ID=$(gpg --list-secret-keys --keyid-format=long "$USER_EMAIL" | grep sec | awk '{print $2}' | cut -d'/' -f2 | head -1)
        echo "✓ Found existing GPG key for $USER_EMAIL"
        echo "  Key ID: $KEY_ID"
    else
        # Keys exist but not for this email - list them
        echo "⚠ No GPG key found for $USER_EMAIL"
        echo
        echo "Available keys:"
        gpg --list-secret-keys --keyid-format=long | grep -E "^sec|^uid" | sed 's/^/  /'
        echo
        echo "To import your key, use: gpg --import /path/to/private-key.asc"
        echo "Then run: algalon-apply gpg-setup"
        exit 1
    fi
else
    # No keys at all
    echo "⚠ No GPG keys found on this system"
    echo
    echo "To set up GPG signing:"
    echo "  1. Import your existing key:"
    echo "     gpg --import /path/to/private-key.asc"
    echo
    echo "  2. Or transfer from another machine:"
    echo "     # On old machine:"
    echo "     gpg --export-secret-keys $USER_EMAIL > private-key.asc"
    echo "     # On this machine:"
    echo "     gpg --import private-key.asc"
    echo
    echo "  3. Then run: algalon-apply gpg-setup"
    echo
    exit 1
fi

# Configure git to use the key
CURRENT_KEY=$(git config --global user.signingkey || echo '')
if [ "$CURRENT_KEY" != "$KEY_ID" ]; then
    git config --global user.signingkey "$KEY_ID"
    echo "✓ Git configured with GPG key $KEY_ID"
else
    echo "✓ Git already configured with this key"
fi

if [ "$(git config --global commit.gpgsign || echo 'false')" != "true" ]; then
    git config --global commit.gpgsign true
    echo "✓ Git commit signing enabled"
else
    echo "✓ Git commit signing already enabled"
fi

# Export public key for GitHub (local-only, not committed)
if [ -n "${KEY_ID:-}" ]; then
    gpg --armor --export "$KEY_ID" > ~/.local/share/algalon/gpg-public-key.asc
    echo "✓ Public key exported (local-only)"
    echo
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "To add your key to GitHub for verified commits:"
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo "1. Copy your public key:"
    echo "   cat ~/.local/share/algalon/gpg-public-key.asc | wl-copy"
    echo
    echo "2. Add to GitHub:"
    echo "   https://github.com/settings/gpg/new"
    echo
fi
