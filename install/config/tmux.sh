#!/bin/bash

# Install TPM (Tmux Plugin Manager)

echo "Installing TPM (Tmux Plugin Manager)..."

mkdir -p ~/.config/tmux/plugins

if [ ! -d ~/.config/tmux/plugins/tpm ]; then
  git clone https://github.com/tmux-plugins/tpm ~/.config/tmux/plugins/tpm
  echo "TPM installed"
else
  echo "  TPM already installed"
fi
