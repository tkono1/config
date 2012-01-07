if [ -z "$PS1" ]; then
   return
fi

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
alias grep='grep --color=auto'
alias egrep='grep --color=auto'
alias fgrep='grep --color=auto'

# Load .bash_aliases if exists.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

## History settings.
# Size of history.
HISTSIZE=10000
HISTFILESIZE=10000

# Don't overwrite history file.
shopt -s histappend

# Ignore both space and duplicates.
HISTCONTROL=ignoreboth

# Ingore EOF(Ctrl+D) till 10 times.
IGNOREEOF=10

# Ignore Ctrl+S.
stty stop undef
stty start undef

# Set default editor.
if type 'vim' > /dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

## Login prompt settings.
# Set login prompt.
PS1="\[\033[0;34m\][\u@\h:\w]\[\033[0m\]$ "

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Set umask
umask 022

ulimit -c 0

## Load {/etc/,/usr/local/etc/}bash_completion if exists.
for etc in /etc /usr/local/etc; do
    if [ -f $etc/bash_completion ] && ! shopt -oq posix; then
        . $etc/bash_completion
    fi
    unset etc
done
