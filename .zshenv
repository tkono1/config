# Start of zprof
#zmodload zsh/zprof && zprof

#
## XDG base directories {{
#
mkdir -p "${HOME}/.config"
export XDG_CONFIG_HOME="${HOME}/.config"

mkdir -p "${HOME}/.local/share"
export XDG_DATA_HOME="${HOME}/.local/share"

mkdir -p "${HOME}/.local/state"
export XDG_STATE_HOME="${HOME}/.local/state"

mkdir -p "${HOME}/.cache"
export XDG_CACHE_HOME="${HOME}/.cache"
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
