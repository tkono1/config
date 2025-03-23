## {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add path for brew Apple Silicon.
        if [[ -d /opt/homebrew ]]; then
            eval $(/opt/homebrew/bin/brew shellenv)
        fi
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
# nvm
export NVM_DIR=${XDG_CONFIG_HOME}/nvm
# Remove duplicated path frim ${PATH}.
typeset -U path
## }}
