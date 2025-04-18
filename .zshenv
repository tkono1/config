# Start of zprof
#zmodload zsh/zprof && zprof

#
## XDG base directories {{
#
[[ ! -d ${HOME}/.config ]] && mkdir ${HOME}/.config
export XDG_CONFIG_HOME=${HOME}/.config

[[ ! -d ${HOME}/.local/share ]] && mkdir -p ${HOME}/.local/share
export XDG_DATA_HOME=${HOME}/.local/share

[[ ! -d ${HOME}/.local/state ]] && mkdir -p ${HOME}/.local/state
export XDG_STATE_HOME=${HOME}/.local/state

[[ ! -d ${HOME}/.cache/ ]] && mkdir ${HOME}/.cache
export XDG_CACHE_HOME=${HOME}/.cache
## }}

#
## Zsh settings {{
#
[[ ! -d ${XDG_CONFIG_HOME}/zsh ]] && mkdir ${XDG_CONFIG_HOME}/zsh
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# Prepare zsh directory for history.
[[ ! -d ${XDG_STATE_HOME}/zsh ]] && mkdir ${XDG_STATE_HOME}/zsh

# Prepare zsh directory for zcompdump and zcompcache.
[[ ! -d ${XDG_CACHE_HOME}/zsh ]] && mkdir ${XDG_CACHE_HOME}/zsh

# Disable resume support for macOS.
case ${OSTYPE} in
    darwin*)
        SHELL_SESSIONS_DISABLE=1
        ;;
esac
## }}
