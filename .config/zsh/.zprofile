## {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add path for brew Apple Silicon.
        add_path "/opt/homebrew/sbin"
        add_path "/opt/homebrew/bin"
        ;;
    linux*)
        # Add path for snap
        add_path "/snap/bin"
        # Linuxbrew
        if [[ -d /home/linuxbrew/.linuxbrew ]]; then
            export HOMEBREW_PREFIX="/home/linuxbrew/.linuxbrew"
            export HOMEBREW_CELLAR="/home/linuxbrew/.linuxbrew/Cellar"
            export HOMEBREW_REPOSITORY="/home/linuxbrew/.linuxbrew/Homebrew"
            fpath[1,0]="/home/linuxbrew/.linuxbrew/share/zsh/site-functions"
            export PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin${PATH+:$PATH}"
            [ -z "${MANPATH-}" ] || export MANPATH=":${MANPATH#:}"
            export INFOPATH="/home/linuxbrew/.linuxbrew/share/info:${INFOPATH:-}"
        fi
        # Disable auto compinit at /etc/zsh/zshrc on Ubuntu.
        export skip_global_compinit=1
        ;;
esac

# Add path for local bin.
add_path "${HOME}/.local/bin"
# nvm and npm.
if $(command -v nvm > /dev/null 2>&1); then
    [[ ! -d ${XDG_CONFIG_HOME}/nvm ]] && mkdir ${XDG_CONFIG_HOME}/nvm
    export NVM_DIR=${XDG_CONFIG_HOME}/nvm
    [[ ! -d ${XDG_CONFIG_HOME}/npm ]] && mkdir ${XDG_CONFIG_HOME}/npm
    export NPM_CONFIG_USERCONFIG=${XDG_CONFIG_HOME}/npm/npmrc
fi
# Remove duplicated path frim ${PATH}.
typeset -U path
## }}
