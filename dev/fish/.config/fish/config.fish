if status is-interactive
    # Commands to run in interactive sessions can go here
end

# Add params to built in fish ls function
function ls
    command ls -AG $argv
end
