if [ -z "$PS1" ]; then
   return
fi

#
## General options {{
#
# Ingore EOF(Ctrl+D) till 10 times.
IGNOREEOF=10

# Ignore Ctrl+S.
stty stop undef
stty start undef

# Check the window size after each command and
# update the values of LINES and COLUMNS if necessary.
shopt -s checkwinsize

# Set umask.
umask 022

# Set coredump file size to 0.
ulimit -c 0
## }}

#
## Language settings {{                     
#                
export LANG=en_US.UTF-8
## }}

## Set 24-bit color {{
#
if [[ -n ${WSLENV} ]] || [[ -n ${SSH_CLIENT} ]]; then
    export COLORTERM='truecolor'
fi
## }}

#
## Completion {{
# Load {/etc/,/usr/local/etc/}bash_completion if exists.
for etc in /etc /usr/local/etc; do
    if [ -f $etc/bash_completion ] && ! shopt -oq posix; then
        . $etc/bash_completion
    fi
    unset etc
done
## }}

#
## History settings {{
#
# Size of history.
HISTSIZE=10000
HISTFILESIZE=10000

# Don't overwrite history file.
shopt -s histappend

# Ignore both space and duplicates.
HISTCONTROL=ignoreboth
## }}

#
## Prompt settings {{
#
PS1="\[\e[1;32m\][\u@\h\[\e[1;36m\]:\w\[\e[1;32m\]]\$ \[\e[0m\]"
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
        if [[ -f ~/.config/dir_colors ]]; then
            eval $(cat ~/.config/dir_colors)
        else
            export LS_COLORS='di=01;94'
        fi
        ;;
esac
    
# Let GPG to use pinentry TTY.
if type 'gpg' > /dev/null 2>&1; then
    export GPG_TTY=${TTY}
fi
##}}

#
## Aliases {{
#
alias ll='ls -lAF'
if type 'nvim' > /dev/null 2>&1; then
    alias vi='nvim'
    alias vim='nvim'
elif type 'vim' > /dev/null 2>&1; then
    alias vi='vim'
fi
if type 'tmux' > /dev/null 2>&1; then
    if [[ $(tmux -V|grep -o -E "([0-9]+\.)([0-9])") -lt 3.1 ]]; then
        alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
    fi
    [[ -n ${TMUX} ]] && alias ssh='env TERM=xterm-256color ssh'
    export TMUX_TMPDIR=/tmp
fi

# Load .bash_aliases if exists.
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
## }}
