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
case ${OSTYPE} in
    darwin*)
        # Add a path for brew Intel.
        if [[ -d /usr/local/sbin ]]; then
            export PATH=/usr/local/sbin:${PATH}
        fi
        if [[ -d /usr/local/bin ]]; then
            export PATH=/usr/local/bin:${PATH}
        fi
        # Add a path for brew Apple Silicon.
        if [[ -d /opt/homebrew/sbin ]]; then
            export PATH=/opt/homebrew/sbin:${PATH}
        fi
        if [[ -d /opt/homebrew/bin ]]; then
            export PATH=/opt/homebrew/bin:${PATH}
        fi
        # Set path to python modules.
        PY3_PATH=$(python3 -V | awk -F'[ .]' '{print $2"."$3}')
        if [[ -d ${HOME}/Library/Python/${PY3_VER}/bin ]]; then
            export PATH=${HOME}/Library/Python/${PY3_VER}/bin:${PATH}
        fi
        ;;
    linux*)
        if [[ -d /usr/local/sbin ]]; then
            export PATH=/usr/local/sbin:${PATH}
        fi
        if [[ -d /usr/local/bin ]]; then
            export PATH=/usr/local/bin:${PATH}
        fi
        if [[ -d ${HOME}/.local/bin ]]; then
            export PATH=${HOME}/.local/bin:${PATH}
        fi
        if [[ -d ${XDG_DATA_HOME}/npm/bin ]]; then
            export PATH=${XDG_DATA_HOME}/npm/bin:${PATH}
        fi
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac
## }}
