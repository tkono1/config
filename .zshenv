#
## Set XDG base directories {{
#
if [ ! -d ${HOME}/.config ]; then
    mkdir ${HOME}/.config
fi

if [ -d ${HOME}/.config ]; then
    export XDG_CONFIG_HOME=${HOME}/.config
    #export XDG_CACHE_HOME=${HOME}/.cache
    #export XDG_DATA_HOME=${HOME}/.local/share
    #export XDG_RUNTIME_DIR=
fi
## }}

#
## Zsh settings. {{
#
if [ ! -d ${XDG_CONFIG_HOME}/zsh ]; then
    mkdir ${XDG_CONFIG_HOME}/zsh
fi

if [ -d ${XDG_CONFIG_HOME}/zsh ]; then
    export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
fi

if [ -d ${ZDOTDIR}/functions ]; then
    export FPATH="${ZDOTDIR}/functions:$FPATH"
fi

limit coredumpsize 0
## }}

#
## Set command path {{
#
# Add brew path.
if [ -d /usr/local/sbin ]; then
    export PATH=/usr/local/sbin:${PATH}
fi

# Set path to python modules.
if [ -d ${HOME}/Library/Python/3.9/bin ]; then
    export PATH=${HOME}/Library/Python/3.9/bin:${PATH}
fi
## }}
