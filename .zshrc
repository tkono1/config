## Language setting.
export LANG=en_US.UTF-8

## Completion
# Set auto completion.
autoload -Uz compinit
compinit

# Color setting.
autoload -Uz colors
colors

# Try to make the completion list smaller.
setopt list_packed

# If a parameter is completed whose content is the name
# of a directory, then add a trailing slash instead of a space.
setopt auto_param_slash

# Disable beep.
setopt no_beep

# Disable beep when complete list displayed.
setopt nolistbeep

## Input/Output
# Try to correct the spelling of commands.
setopt correct

# Do not exit on end-of-file.
setopt ignore_eof

# Allow comments even in interactive shells
setopt interactive_comments

# Print eight bit characters literally in completion lists.
setopt print_eight_bit

## Keybindings.
# Set emacs-like keybinding.
bindkey -e

## Prompt settings.
case ${UID} in
0)
    PROMPT="%{${fg[blue]}%}[%n@%m:%~]#%{${reset_color}%} "
    PROMPT2="%{${fg[blue]}%}[%_]$%{${reset_color}%} "
    SPROMPT="%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    ;;
*)
    PROMPT="%{${fg[blue]}%}[%n@%m:%~]$%{${reset_color}%} "
    PROMPT2="%{${fg[blue]}%}[%_]$%{${reset_color}%} "
    SPROMPT="%{${fg[blue]}%}%r is correct? [n,y,a,e]:%{${reset_color}%} "
    ;;
esac

## History
# Location of history file.
HISTFILE=~/.zsh_history

# Size of history file.
HISTSIZE=10000
SAVEHIST=10000

# Share command history.
setopt share_history

# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt hist_ignore_dups

# If a new command line being added to the history list
# duplicates an older one, the older command is removed.
setopt hist_ignore_all_dups

# Remove command lines from the history list 
# when the first charactoer on the line is a space.
setopt hist_ignore_space

# Remove superfluous blanks from each command line
# being added to the history list.
setopt hist_reduce_blanks

## Aliases.
if [ `uname` = "Darwin" -o `uname` = "FreeBSD" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -lAF'
if type 'nvim' > /dev/null 2>&1; then
    alias vi='nvim'
elif type 'vim' > /dev/null 2>&1; then
    alias vi='vim'
fi
if type 'tmux' > /dev/null 2>&1; then
    tmux="tmux -f $XDG_CONFIG_HOME/tmux/tmux.conf"
    export TMUX_TMPDIR="$XDR_RUNTIME_DIR"
fi
