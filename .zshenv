#
## XDG base directories {{
#
# Prepare XDG base directories.
[[ ! -d ${HOME}/.config ]] && mkdir ${HOME}/.config
[[ ! -d ${HOME}/.local/share ]] && mkdir -p ${HOME}/.local/share
[[ ! -d ${HOME}/.cache/ ]] && mkdir ${HOME}/.cache

# export XDG base directories.
[[ -d ${HOME}/.config ]] && export XDG_CONFIG_HOME=${HOME}/.config
[[ -d ${HOME}/.local/share ]] && export XDG_DATA_HOME=${HOME}/.local/share
[[ -d ${HOME}/.cache/ ]] && export XDG_CACHE_HOME=${HOME}/.cache
## }}

#
## Zsh settings {{
#
# Prepare and export ZDOTDIR.
[[ ! -d ${XDG_CONFIG_HOME}/zsh ]] && mkdir ${XDG_CONFIG_HOME}/zsh
[[ -d ${XDG_CONFIG_HOME}/zsh ]] && export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

# Prepare and ddd user's FPATH.
[[ ! -d ${ZDOTDIR}/functions ]] && mkdir ${ZDOTDIR}/functions
[[ -d ${ZDOTDIR}/functions ]] && export FPATH="${ZDOTDIR}/functions:$FPATH"

# Set core dump size to 0.
limit coredumpsize 0
## }}

#
## Set command path {{
#
case ${OSTYPE} in
    darwin*)
        # Add brew path for Intel.
        if [[ -d /usr/local/sbin ]]; then
            export PATH=/usr/local/sbin:${PATH}
        fi
        # Add brew path for Apple Silicon.
        if [[ -d /opt/homebrew/sbin ]]; then
            export PATH=/opt/homebrew/sbin:${PATH}
        fi
        # Set path to python modules.
        if [[ -d ${HOME}/Library/Python/3.9/bin ]]; then
            export PATH=${HOME}/Library/Python/3.9/bin:${PATH}
        fi
        ;;
    linux*)
        if [[ -d /usr/local/sbin ]]; then
            export PATH=/usr/local/sbin:${PATH}
        fi
        if [[ -d ${HOME}/.local/bin ]]; then
            export PATH=${HOME}/.local/bin:${PATH}
        fi
        ;;
esac
## }}
