if [ -z "$PS1" ]; then
   return
fi

alias ll='ls -lAF'

# Size of history.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Ignore both space and duplicates.
export HISTCONTROL=ignoreboth

# Ingore EOF(Ctrl+D) till 10 times.
export IGNOREEOF=10

# Set default editor.
export EDITOR=vim

# Set login prompt.
PS1="\[\033[0;34m\][\u@\h:\w]\[\033[0m\]$ "

# Ignore Ctrl+S.
stty stop undef
stty start undef

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
