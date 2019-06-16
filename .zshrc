## Auto completion settings.
# Set auto completion.
autoload -Uz compinit
compinit

# Color settings.
autoload -Uz colors
colors

# Show dense list. 
setopt list_packed

# Disable beep when complete list displayed.
setopt nolistbeep

# Correct command.
setopt correct

## Language setting.
export LANG=en_US.UTF-8

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

## History settings.
# Location of history file.
HISTFILE=~/.zsh_history

# Size of history file.
HISTSIZE=10000
SAVEHIST=10000

# Ignore duplication from command history.
setopt hist_ignore_dups

# Share command history.
setopt share_history

## Aliases.
if [ `uname` = "Darwin" -o `uname` = "FreeBSD" ]; then
    alias ls='ls -G'
else
    alias ls='ls --color=auto'
fi
alias ll='ls -lAF'
if type 'vim' > /dev/null 2>&1; then
    alias vi='vim'
fi
if [ -d /Applications/MacVim.app ]; then
    alias macvim='open -a /Applications/MacVim.app "$@"'
fi
