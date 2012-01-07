if [ -z "$PS1" ]; then
   return
fi

# Aliases.
alias ll='ls -lAF'
if type 'vim' > /dev/null 2>&1; then
    alias vi='vim'
fi

# Size of history.
HISTSIZE=10000
HISTFILESIZE=10000

# Ignore both space and duplicates.
HISTCONTROL=ignoreboth

# Ingore EOF(Ctrl+D) till 10 times.
IGNOREEOF=10

# Set default editor.
if type 'vim' > /dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

# Set login prompt.
PS1="\[\033[0;34m\][\u@\h:\w]\[\033[0m\]$ "

# Ignore Ctrl+S.
stty stop undef
stty start undef

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize
