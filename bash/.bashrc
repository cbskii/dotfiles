# Keep system specific functionality in a different file that is not uploaded to Github.
if [ -e $HOME/.bashrc-extra ]; then
    source $HOME/.bashrc-extra
fi

# Aliases
alias ls='ls -AlghGX --color'

# Catppuccin FZF colors
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#cba6f7,pointer:#f5e0dc \
--color=marker:#f5e0dc,fg+:#cdd6f4,prompt:#cba6f7,hl+:#f38ba8"

# Keep at end of file
eval "$(starship init bash)"
