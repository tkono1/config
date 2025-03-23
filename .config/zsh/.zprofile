## {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add homebrew environments for Apple Silicon.
        if [[ -d /opt/homebrew ]]; then
            eval $(/opt/homebrew/bin/brew shellenv)
        fi
        ;;
    linux*)
        # Add path for snap
        add_path "/snap/bin"
        # Add homebrew envirinments for Linux.
        if [[ -d /home/linuxbrew/.linuxbrew ]]; then
            eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
        fi
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac

# Add path for local bin.
add_path "${HOME}/.local/bin"
# nvm
export NVM_DIR=${XDG_CONFIG_HOME}/nvm
# Remove duplicated path frim ${PATH}.
typeset -U path
## }}
