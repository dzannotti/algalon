#!/bin/bash

echo "Installing VSCode extensions..."

# Install extensions with --force to handle updates/reinstalls
code --install-extension --force Catppuccin.catppuccin-vsc
code --install-extension --force Catppuccin.catppuccin-vsc-icons
code --install-extension --force bierner.github-markdown-preview
code --install-extension --force bierner.markdown-mermaid
code --install-extension --force biomejs.biome
code --install-extension --force davidanson.vscode-markdownlint
code --install-extension --force donjayamanne.githistory
code --install-extension --force eamodio.gitlens
code --install-extension --force editorconfig.editorconfig
code --install-extension --force oderwat.indent-rainbow
code --install-extension --force oven-sh.bun-vscode
code --install-extension --force pmneo.tsimporter
code --install-extension --force streetsidesoftware.code-spell-checker
code --install-extension --force tamasfe.even-better-toml
code --install-extension --force timonwong.shellcheck
code --install-extension --force yoavbls.pretty-ts-errors
code --install-extension --force yzhang.markdown-all-in-one

echo "✓ VSCode extensions installed"
