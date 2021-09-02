## Zsh settings.
export ZDOTDIR=${HOME}/.config/zsh
if [ -d ${HOME}/.config/zsh/functions ]; then
    export FPATH="${HOME}/.config/zsh/functions:$FPATH"
fi

## Set XDG dirs
export XDG_CONFIG_HOME=${HOME}/.config
#export XDG_CACHE_HOME=${HOME}/.cache
#export XDG_DATA_HOME=${HOME}/.local/share
#export XDG_RUNTIME_DIR=
