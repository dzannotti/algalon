#!/bin/bash

# Add ./bin to path for all items in ~/code
mkdir -p "$HOME/code"

cat >"$HOME/code/.mise.toml" <<'EOF'
[env]
_.path = "{{ cwd }}/bin"
EOF

mise trust ~/code/.mise.toml

# Install and set global versions
echo "Installing Node.js..."
mise install node@latest
mise use -g node@latest

echo "Installing Bun..."
mise install bun@latest
mise use -g bun@latest

echo "Installing Go..."
mise install go@latest
mise use -g go@latest

echo "Installing Rust (this may take a while)..."
mise install rust@latest
mise use -g rust@latest
