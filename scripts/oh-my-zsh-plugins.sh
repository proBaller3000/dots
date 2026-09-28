#!/bin/bash

# Script to stow zsh config
# Removes existing ~/.zshrc if present, then stows the dotfiles version

set -e

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

echo "Zsh zsh-autosuggestions and zsh-syntax-highlighting cloned"
echo "==============="
echo "Done!"
