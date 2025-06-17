if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Support both emacs and vi mode key bindings
function fish_user_key_bindings
    fish_default_key_bindings -M insert
    fish_vi_key_bindings --no-erase insert
end

# Support 'jk' to exit insert mode similar to neovim
bind --mode insert --sets-mode default jk repaint

# Cursor appearance in vi mode
set fish_cursor_default block
set fish_cursor_insert block

# Show more output with ls
alias ls="(ls) -A"
