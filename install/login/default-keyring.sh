# Create a default keyring for SSH keys and credentials
# Works headless - gnome-keyring-daemon doesn't require GNOME desktop

KEYRING_DIR="$HOME/.local/share/keyrings"
KEYRING_FILE="$KEYRING_DIR/Default_keyring.keyring"
DEFAULT_FILE="$KEYRING_DIR/default"

mkdir -p $KEYRING_DIR

cat << EOF | tee "$KEYRING_FILE" >/dev/null
[keyring]
display-name=Default keyring
ctime=$(date +%s)
mtime=0
lock-on-idle=false
lock-after=false
EOF

cat << EOF | tee "$DEFAULT_FILE" >/dev/null
Default_keyring
EOF

chmod 700 "$KEYRING_DIR"
chmod 600 "$KEYRING_FILE"
chmod 644 "$DEFAULT_FILE"

# Auto-start gnome-keyring-daemon for SSH key management
# Add to shell profile if not already present
ZSHRC="$HOME/.config/zsh/zshrc"
if [ -f "$ZSHRC" ] && ! grep -q "gnome-keyring-daemon" "$ZSHRC"; then
  cat >> "$ZSHRC" << 'EOF'

# Start gnome-keyring-daemon for SSH key management
if [ -n "$DESKTOP_SESSION" ] || [ -n "$SSH_CONNECTION" ]; then
  eval $(gnome-keyring-daemon --start --components=ssh,secrets 2>/dev/null)
  export SSH_AUTH_SOCK
fi
EOF
fi

echo "✓ Default keyring created (passwordless for SSH keys)"
