if [ -z "$PS1" ]; then
   return
fi

alias ll='ls -lAF'

export HISTSIZE=10000
export HISTCONTROLL=ignoreboth
export IGNOREEOF=10
export EDITOR=vim

PS1="\[\033[0;34m\][\u@\h:\w]\[\033[0m\]$ "

stty stop undef
stty start undef
