#!/bin/bash

# Change default shell to zsh
if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing default shell to zsh..."
    chsh -s $(which zsh)
fi

# Copy root zshrc that sources our config files
if [ -f "$ALGALON_PATH/default/zshrc" ]; then
    cp "$ALGALON_PATH/default/zshrc" ~/.zshrc
fi
