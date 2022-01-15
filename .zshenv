#
## Create XDG base directories {{
#
if [[ ! -d ${HOME}/.config ]]; then
    mkdir ${HOME}/.config
fi
if [[ ! -d ${HOME}/.local/share ]]; then
    mkdir -p ${HOME}/.local/share
fi
## }}

#
## Set XDG base directories {{
#
if [[ -d ${HOME}/.config ]]; then
    export XDG_CONFIG_HOME=${HOME}/.config
fi
if [[ -d ${HOME}/.cache/ ]]; then
    export XDG_CACHE_HOME=${HOME}/.cache
fi
if [[ -d ${HOME}/.local/share ]]; then
    export XDG_DATA_HOME=${HOME}/.local/share
fi
## }}

#
## Zsh settings {{
#
if [[ ! -d ${XDG_CONFIG_HOME}/zsh ]]; then
    mkdir ${XDG_CONFIG_HOME}/zsh
fi

export ZDOTDIR=${XDG_CONFIG_HOME}/zsh

if [[ -d ${ZDOTDIR}/functions ]]; then
    export FPATH="${ZDOTDIR}/functions:$FPATH"
fi

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
