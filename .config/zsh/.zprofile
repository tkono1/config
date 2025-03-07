## {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add path for brew Apple Silicon.
        [[ -d /opt/homebrew/sbin ]] && add_path "/opt/homebrew/sbin"
        [[ -d /opt/homebrew/bin ]] && add_path "/opt/homebrew/bin"
        ;;
    linux*)
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac

# Add path for local bin.
[[ -d ${HOME}/.local/bin ]] && add_path "${HOME}/.local/bin"
# Add path for snap
[[ -d /snap/bin ]] && add_path "/snap/bin"
# zsh-nvm
[[ -d ${XDG_CONFIG_HOME}/nvm ]] && export NVM_DIR=${XDG_CONFIG_HOME}/nvm
# npm
[[ -d ${XDG_CONFIG_HOME}/npm ]] && export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
# Remove duplicated path frim ${PATH}.
typeset -U path
## }}
