#!/bin/zsh

# Prerequisites
brew install stow
brew install python3
python3 -m pip install --upgrade pip
brew install git

# Zsh setup with Oh My Zsh and Spaceship prompt
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/denysdovhan/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"
rm ~/.zshrc # remove default zshrc
stow zsh # symlink new zshrc to home directory

# Universtal Ctags
brew unlink ctags
brew install --HEAD universal-ctags/universal-ctags/universal-ctags

# FZF
brew install fzf
$(brew --prefix)/opt/fzf/install

# Ripgrep
brew install ripgrep

# Neovim setup
brew install neovim
mkdir -p ~/.config/nvim
python3 -m pip install --user --upgrade pynvim
cp nvim/init.vim ~/.config/nvim
stow vim # symlink vimrc to home directory (which is used by nvim)

# Apply changes
source ~/.zshrc
