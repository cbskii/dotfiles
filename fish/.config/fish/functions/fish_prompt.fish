function fish_prompt --description 'Write out the prompt'
        set -l main_color yellow
        set -l last_status $status
        set -l normal (set_color normal)
        set -l status_color (set_color $main_color)
        set -l cwd_color (set_color $main_color --bold)
        set -l prompt_status ""

        set -l prompt_login_color (set_color grey --italics)
        set -U fish_color_user grey --italics
        set -U fish_color_host grey --italics

        set -g __fish_git_prompt_showdirtystate 1
        set -g __fish_git_prompt_showstashstate 1
        set -g __fish_git_prompt_showupstream auto
        set -g __fish_git_prompt_showcolorhints 1
        set -g __fish_git_prompt_char_stateseparator '|'
        set -g __fish_git_prompt_char_upstream_ahead '↑'
        set -g __fish_git_prompt_char_upstream_behind '↓'
        set -g __fish_git_prompt_color $main_color
        set -g __fish_git_prompt_color_branch $main_color

        set -q fish_prompt_pwd_dir_length
        or set -lx fish_prompt_pwd_dir_length 0

        # Color the prompt differently when we're root
        set -l suffix '❯'
        if functions -q fish_is_root_user; and fish_is_root_user
                if set -q fish_color_cwd_root
                        set cwd_color (set_color $fish_color_cwd_root --bold)
                end
                set suffix '#'
        end

        # Color the prompt in red on error
        if test $last_status -ne 0
                set status_color (set_color $fish_color_error)
                set prompt_status $status_color "[" $last_status "]" $normal
        end

        echo ''
        echo -s $prompt_login_color "$USER" \
                $prompt_login_color "@" \
                $prompt_login_color (prompt_hostname) \
                $normal
        switch $fish_bind_mode
                case default
                    set_color --bold blue
                    echo -n '[N] '
                case insert
                    set_color --bold green
                    echo -n '[I] '
                case visual
                    set_color --bold magenta
                    echo -n '[V] '
                case '*'
                    set_color --bold yellow
                    echo -n '[?] '
            end
        echo -s $cwd_color (prompt_pwd) \
                $normal (fish_git_prompt) \
                $normal ' ' $prompt_status
        echo -n -s $status_color $suffix ' ' $normal
end
