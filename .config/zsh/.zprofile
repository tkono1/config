## {{
add_path(){
    if [[ -d $1 ]]; then
        export PATH=$1:${PATH}
    fi
}

case ${OSTYPE} in
    darwin*)
        # Add a path for brew Intel.
        add_path "/usr/local/sbin"
        add_path "/usr/local/bin"
        # Add a path for brew Apple Silicon.
        add_path "/opt/homebrew/sbin"
        add_path "/opt/homebrew/bin"
        # Set path to python modules.
        if (( ${+commands[python3]} )); then
            local py3_ver=$(python3 -V | awk -F'[ .]' '{print $2"."$3}')
                 add_path "${HOME}/Library/Python/${py3_ver}/bin"
        fi
        unset py3_ver
        # Remove duplicated path frim ${PATH}.
        typeset -U path
        ;;
esac
## }}
