#!/bin/zsh

# TODO make work on Linux and Mac (currently Mac specific)

# Prerequisites
brew install stow
# TODO python3, ctags

# Zsh setup with Oh My Zsh and Spaceship prompt
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
rm ~/.zshrc # remove default zshrc
stow zsh # symlink new zshrc to home directory

# Neovim setup
# TODO install neovim python dependencies
brew install neovim
mkdir -p ~/.config/nvim
cp nvim/init.vim ~/.config/nvim
stow vim # symlink vimrc to home directory

# Apply changes
source ~/.zshrc
