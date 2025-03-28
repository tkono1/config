## Application specific settings before loading plugins {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add homebrew environments for Apple Silicon.
        if [[ -x /opt/homebrew/bin/brew ]]; then
            eval $(/opt/homebrew/bin/brew shellenv)
        fi
        ;;
    linux*)
        # Add path for snap
        add_path "/snap/bin"
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        # Add homebrew envirinments for Linux.
        if [[ -x /home/linuxbrew/.linuxbrew/bin/brew ]]; then
            eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        fi
        ;;
esac

# Set NVM_DIR before loading nvm plugin.
export NVM_DIR=${XDG_CONFIG_HOME}/nvm

# Add path for local bin.
add_path "${HOME}/.local/bin"
## }}

#
## General settings {{
#
# Set language.
export LANG=en_US.UTF-8

# Ignore Ctrl+S.
stty stop undef
stty start undef

# Do not exit on end-of-file.
setopt ignore_eof

# Try to correct the spelling of commands.
setopt correct

# Disable beep.
setopt no_beep

# Suppress "no matches" message. 
setopt nonomatch

# Disable core dump.
limit coredumpsize 0

# Set emacs-like keybinding.
bindkey -e
## }}

#
## Plugins {{
#
### Added by Zinit's installer
if [[ ! -f ${HOME}/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "${HOME}/.local/share/zinit" && command chmod g-rwX "${HOME}/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "${HOME}/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

declare -A ZINIT
ZINIT[ZCOMPDUMP_PATH]=${XDG_CACHE_HOME}/zsh
ZINIT[COMPINIT_OPTS]="-D"

source "${XDG_DATA_HOME}/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

# Load plugins.
case ${OSTYPE} in
    darwin*)
        zinit light woefe/git-prompt.zsh
        ;;
    linux*)
        zinit light woefe/git-prompt.zsh
        zinit light lukechilds/zsh-nvm
        ;;
esac
## }}

#
## Color settings {{
#
# Set 24-bit color even though WSL or remote.
if [[ -n ${WSLENV} ]] || [[ -n ${SSH_CLIENT} ]]; then
    export COLORTERM='truecolor'
fi
## }}

#
## Completion {{
#
# Set auto completion.
autoload -Uz compinit && compinit -d ${XDG_CACHE_HOME}/zsh/.zcompdump
# Disable zcompdump with -D option.
#autoload -Uz compinit && compinit -D

# Set location of zcompcache directory.
#zstyle ':completion:*' cache-path ${XDG_CACHE_HOME}/zsh/zcompcache

# Colorize completion items.
zstyle ':completion:*' list-colors di=34 ln=35 ex=31

# Highlight completion items.
zstyle ':completion:*:default' menu select=2

# Try to make the completion list smaller.
setopt list_packed

# Add a trailing slash to name of a directory instead of a space.
setopt auto_param_slash

# Remove trailing spaces after completion if needed.
setopt auto_param_keys

# Show the type of each file with a trailing identifying mark.
setopt list_types

# Automatically use menu completion after the second consecutive rquest.
setopt auto_menu

# Files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

# The cursor stays there and completion is done from both ends.
setopt complete_in_word

# Print eight bit characters literally in completion lists.
setopt print_eight_bit

# Allow comments even in interactive shells
setopt interactive_comments

# Disable beep when complete list displayed.
setopt nolistbeep
## }}

#
## History {{
#
# Location of history file.
HISTFILE=${XDG_STATE_HOME}/zsh/history

# Size of history file.
HISTSIZE=10000
SAVEHIST=10000

# Share command history.
setopt share_history

# Do not enter duplicated command lines into the history list.
setopt hist_ignore_dups

# Remove older duplicated command from the history list.
setopt hist_ignore_all_dups

# Remove command if first character is space lines from the history list. 
setopt hist_ignore_space

# Do not add history command to the history list.
setopt hist_no_store

# Remove superfluous blanks from each command line from the history list.
setopt hist_reduce_blanks
## }}

#
## Prompt settings {{
#
# Git prompt settings.
if (( ${+commands[git]} )) && [ -e ${^fpath}/git-prompt.zsh(N) ]; then
    ZSH_GIT_PROMPT_FORCE_BLANK=1
    ZSH_GIT_PROMPT_SHOW_UPSTREAM="no"
    ZSH_THEME_GIT_PROMPT_PREFIX="["
    ZSH_THEME_GIT_PROMPT_SUFFIX="]"
    ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
    ZSH_THEME_GIT_PROMPT_DETACHED="%B%F{cyan}:%f%b"
    ZSH_THEME_GIT_PROMPT_BRANCH="%B%F{blue}"
    ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%B%F{yellow}⟳ %f%b"
    ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%F{red}(%f%F{yellow}"
    ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%F{red})%f"
    ZSH_THEME_GIT_PROMPT_BEHIND="%F{yellow}↓%f"
    ZSH_THEME_GIT_PROMPT_AHEAD="%F{yellow}↑%f"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%F{red}✖%f"
    ZSH_THEME_GIT_PROMPT_STAGED="%F{green}●%f"
    ZSH_THEME_GIT_PROMPT_UNSTAGED="%F{red}✚%f"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
    ZSH_THEME_GIT_PROMPT_STASHED="%F{blue}⚑%f"
    ZSH_THEME_GIT_PROMPT_CLEAN="%B%F{green}✔%f"
    RPROMPT='$(gitprompt)'
fi

# Command prompt settings.
#PROMPT="%B%F{034}[%n@%m%F{004}:%~%F{034}]%#%f%b "
PROMPT="%B%K{044}%F{023} %n@%m %k%K{023}%F{044} %~%F{004} %#%f%k%b "
PROMPT2="%F{034}[%_]%#%k%f "
SPROMPT="%F{034}%r is correct? [n,y,a,e]:%k%f "

#
## Command specific settings {{
#
# Disable less history.
export LESSHISTFILE=-

# ls color.
case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        export LSCOLORS=Exfxcxdxbxegedabagacad
        ;;
    linux*)
        alias ls='ls --color=auto'
        if [[ -f ${XDG_CONFIG_HOME}/dir_colors ]]; then
            eval $(dircolors ${XDG_CONFIG_HOME}/dir_colors)
        else
            export LS_COLORS='di=01;34'
        fi
        ;;
esac
    
# Don't print any hits of Homebrew.
if (( ${+commands[brew]} )); then
    export HOMEBREW_NO_ENV_HINTS=1
fi

# Python
export PYTHON_HISTORY=${XDG_STATE_HOME}/python_history
export PYTHONPYCACHEPREFIX=${XDG_CACHE_HOME}/python
export PYTHONUSERBASE=${XDG_DATA_HOME}/python

# pyenv
if (( ${+commands[pyenv]} )); then
    [[ ! -d ${XDG_DATA_HOME}/pyenv ]] && mkdir ${XDG_DATA_HOME}/pyenv
    export PYENV_ROOT="${XDG_DATA_HOME}/pyenv"
    eval "$(pyenv init -)"
fi

# npm
if [ -e ${^fpath}/zsh-nvm.zsh(N) ]; then
    [[ ! -d ${XDG_CONFIG_HOME}/npm ]] && mkdir ${XDG_CONFIG_HOME}/npm
    export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
fi
# }}

#
## Aliases {{
#
alias ll='ls -lAF'
if (( ${+commands[nvim]} )); then
    alias vi='nvim'
    alias vim='nvim'
    export EDITOR='nvim'
elif (( ${+commands[vim]} )); then
    alias vi='vim'
    export EDITOR='vim'
fi
if (( ${+commands[tmux]} )); then
    [[ -n ${TMUX} ]] && alias ssh='env TERM=xterm-256color ssh'
    export TMUX_TMPDIR=/tmp
fi
## }}

# Remove duplicated path frim ${PATH}.
typeset -U path

# End of zprof
#if (which zprof > /dev/null) ;then
#  zprof | less
#fi
