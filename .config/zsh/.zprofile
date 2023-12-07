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
        # Set path to python modules.
        if (( ${+commands[python3]} )); then
            local py3_ver=$(python3 -V | awk -F'[ .]' '{print $2"."$3}')
            add_path "${HOME}/Library/Python/${py3_ver}/bin"
            unset py3_ver
        fi
        # Remove duplicated path frim ${PATH}.
        typeset -U path
        ;;
    linux*)
        # Add path for local bin.
        [[ -d ${HOME}/.local/bin ]] && add_path "${HOME}/.local/bin"
        # Add path for snap
        [[ -d /snap/bin ]] && add_path "/snap/bin"
        # zsh-nvm
        export NVM_DIR=${XDG_CONFIG_HOME}/nvm
        # npm
        [[ -d ${XDG_CONFIG_HOME}/npm ]] && export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        # Remove duplicated path frim ${PATH}.
        typeset -U path
        ;;
esac
## }}
