# ~/.config/fish/config.fish: executed by fish for non-login shells.

# If not running interactively, don't do anything
if status is-interactive
    # don't put duplicate lines or lines starting with space in the history.
    set -U fish_history_ignore_space
    set -U fish_history_ignore_duplicates

    # append to the history file, don't overwrite it
    set -U fish_history_save 

    # for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
    set -U fish_history_max 1000

    # check the window size after each command and, if necessary,
    # update the values of LINES and COLUMNS.
    function update_term_size --on-variable fish_pid
        eval (resize)
    end

    # make less more friendly for non-text input files, see lesspipe(1)
    if test -x /usr/bin/lesspipe
        set -x LESSOPEN "| /bin/sh lesspipe %s"
    end

    # set a fancy prompt
    if set -q fish_color_autosuggestion
        set -U fish_color_autosuggestion brgreen
    end

    # some more ls aliases
    alias ll='ls -alF'
    alias la='ls -A'
    alias l='ls -CF'

    # Add an "alert" alias for long running commands.  Use like so:
    #   sleep 10; alert
    function alert
      if test $status -eq 0
        set alert_icon terminal
      else
        set alert_icon error
      end
      notify-send --urgency=low -i $alert_icon (history | tail -n1 | string trim)
    end


    # Alias definitions.
    if test -f ~/.config/fish/aliases.fish
        source ~/.config/fish/aliases.fish
    end

    # add cargo to path
    if contains $HOME/.cargo/bin $PATH
      set -x PATH $HOME/.cargo/bin $PATH
    end

    # distro-specific config
    if test -f /etc/debian_version
      source ~/.config/fish/debian.fish
    end
end

