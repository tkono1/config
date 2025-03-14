#
## XDG base directories {{
#
# Prepare and export XDG base directories.
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
## Set command path {{
#
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add a path for brew Apple Silicon.
        add_path "/opt/homebrew/sbin"
        add_path "/opt/homebrew/bin"
        # Set path to python modules.
        ;;
    linux*)
        # Add path for snap
        add_path "/snap/bin"
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac
# Add a path for local bin.
add_path "${HOME}/.local/bin"
# nvm
export NVM_DIR=${XDG_CONFIG_HOME}/nvm
## }}
#
## Load .bashrc {{
#
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
## }}
