if [ -z "$PS1" ]; then
   return
fi

## History settings {{
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
## }}

# Set default editor.
if type 'nvim' > /dev/null 2>&1; then
    export EDITOR=nvim
elif type 'vim' > /dev/null 2>&1; then
    export EDITOR=vim
else
    export EDITOR=vi
fi

#
## Set 24-bit color {{
#
if [[ -n ${WSLENV} ]] || [[ -n ${SSH_CLIENT} ]]; then
    export COLORTERM='truecolor'
fi
## }}

# Check the window size after each command and
# update the values of LINES and COLUMNS if necessary.
shopt -s checkwinsize

# Set umask
umask 022

ulimit -c 0

# Load {/etc/,/usr/local/etc/}bash_completion if exists.
for etc in /etc /usr/local/etc; do
    if [ -f $etc/bash_completion ] && ! shopt -oq posix; then
        . $etc/bash_completion
    fi
    unset etc
done

#
## Prompt settings {{
#
PS1="\[\e[0;32m\][\u@\h\[\e[0;36m\]:\w\[\e[0;32m\]]\$ \[\e[0m\]"
## }}

#
## Command specific settings {{
#
# Disable less history.
export LESSHISTFILE=-

# ls color.
case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        if [[ -f ${HOME}/.dircolors ]]; then
            eval $(cat ${HOME}/.dircolors)
        else
            export LS_COLORS='di=01;94'
        fi
        ;;
esac
    
# Let GPG to use pinentry TTY.
#(( ${+commands[gpg]} )) && export GPG_TTY=${TTY}
##}}

## Aliases {{
alias ll='ls -lAF'
if type 'vim' > /dev/null 2>&1; then
    alias vi='vim'
fi
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Load .bash_aliases if exists.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
## }}
