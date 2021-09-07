## Set XDG dirs
export XDG_CONFIG_HOME=${HOME}/.config
#export XDG_CACHE_HOME=${HOME}/.cache
#export XDG_DATA_HOME=${HOME}/.local/share
#export XDG_RUNTIME_DIR=

## Zsh settings.
export ZDOTDIR=${XDG_CONFIG_HOME}/zsh
if [ -d ${ZDOTDIR}/functions ]; then
    export FPATH="${ZDOTDIR}/functions:$FPATH"
fi

limit coredumpsize 0
