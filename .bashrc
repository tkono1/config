# Check if login shell or not.
if [ -z "$PS1" ]; then
   return
fi

# Set command aliases.
alias ll='ls -lAF'

# Set history length.
export HISTSIZE=10000
export HISTFILESIZE=10000

# Don't put duplicate lines in the history.
export HISTCONTROLL=ignoreboth

# Set to ignore EOF(Ctrl+d) till 10 times.
export IGNOREEOF=10

# Set editor environment.
export EDITOR=vim

# Set prompt.
export PS1="\[\033[0;34m\][\u@\h:\w]\[\033[0m\]$ "

# Ignore Ctrl+s.
stty stop undef
stty start undef

# Check the window size after each command.
shopt -s checkwinsize
