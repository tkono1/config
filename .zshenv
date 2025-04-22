# Start of zprof
#zmodload zsh/zprof && zprof

#
## XDG base directories {{
#
export XDG_CONFIG_HOME="${HOME}/.config"
mkdir -p "${XDG_CONFIG_HOME}"

export XDG_DATA_HOME="${HOME}/.local/share"
mkdir -p "${XDG_DATA_HOME}"

export XDG_STATE_HOME="${HOME}/.local/state"
mkdir -p "${XDG_STATE_HOME}"

export XDG_CACHE_HOME="${HOME}/.cache"
mkdir -p "${XDG_CACHE_HOME}"
## }}

#
## Zsh settings {{
#
export ZDOTDIR="${XDG_CONFIG_HOME}/zsh"
mkdir -p "${ZDOTDIR}"
mkdir -p "${XDG_STATE_HOME}/zsh"
mkdir -p "${XDG_CACHE_HOME}/zsh"

# Disable resume support for macOS. See /etc/zshrc_Apple_Terminal.
case ${OSTYPE} in
    darwin*)
        SHELL_SESSIONS_DISABLE=1
        ;;
esac
## }}
