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
        if (( ${+commands[python3]} )); then
            py3_ver=$(python3 -V | awk -F'[ .]' '{print $2"."$3}')
            if [[ -d ${HOME}/Library/Python/${py3_ver}/bin ]]; then
                export PATH=${HOME}/Library/Python/${py3_ver}/bin:${PATH}
            fi
        fi
        unset py3_ver
        # Remove duplicated path frim ${PATH}.
        typeset -U path
        ;;
esac
## }}
