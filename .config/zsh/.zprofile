## {{
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
        # Remove duplicated path frim ${PATH}.
        typeset -U path
        ;;
esac
## }}
