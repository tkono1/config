#
## XDG base directories {{
#
[[ ! -d ${HOME}/.config ]] && mkdir ${HOME}/.config
[[ -d ${HOME}/.config ]] && export XDG_CONFIG_HOME=${HOME}/.config

[[ ! -d ${HOME}/.local/share ]] && mkdir -p ${HOME}/.local/share
[[ -d ${HOME}/.local/share ]] && export XDG_DATA_HOME=${HOME}/.local/share

[[ ! -d ${HOME}/.local/state ]] && mkdir -p ${HOME}/.local/state
[[ -d ${HOME}/.local/state ]] && export XDG_STATE_HOME=${HOME}/.local/state

[[ ! -d ${HOME}/.cache/ ]] && mkdir ${HOME}/.cache
[[ -d ${HOME}/.cache/ ]] && export XDG_CACHE_HOME=${HOME}/.cache
## }}

#
## Zsh settings {{
#
[[ ! -d ${XDG_CONFIG_HOME}/zsh ]] && mkdir ${XDG_CONFIG_HOME}/zsh
[[ -d ${XDG_CONFIG_HOME}/zsh ]] && export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# Prepare zsh directory for history.
[[ ! -d ${XDG_STATE_HOME}/zsh ]] && mkdir ${XDG_STATE_HOME}/zsh

# Prepare zsh directory for zcompdump and zcompcache.
[[ ! -d ${XDG_CACHE_HOME}/zsh ]] && mkdir ${XDG_CACHE_HOME}/zsh

[[ ! -d ${ZDOTDIR}/functions ]] && mkdir ${ZDOTDIR}/functions
[[ -d ${ZDOTDIR}/functions ]] && export FPATH="${ZDOTDIR}/functions:$FPATH"

# Disable .zsh_sessions.
SHELL_SESSIONS_DISABLE=1

limit coredumpsize 0
## }}

#
## Set command path {{
#
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add a path for brew Intel.
        add_path "/usr/local/sbin"
        add_path "/usr/local/bin"
        # Add a path for brew Apple Silicon.
        add_path "/opt/homebrew/sbin"
        add_path "/opt/homebrew/bin"
        # Set path to python modules.
        if (( ${+commands[python3]} )); then
            local py3_ver=$(python3 -V | awk -F'[ .]' '{print $2"."$3}')
            add_path "${HOME}/Library/Python/${py3_ver}/bin"
            unset py3_ver
        fi
        ;;
    linux*)
        # Add a path for local bin.
        add_path "${HOME}/.local/bin"
        # Add a path for npm
        add_path "${XDG_DATA_HOME}/npm/bin"
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac
## }}
