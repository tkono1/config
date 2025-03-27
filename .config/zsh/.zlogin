if ls ${HOME}/.ssh | grep -q 'id_*'; then
    case ${OSTYPE} in
        darwin*)
        ## Load SSH keys from Keychain.
            /usr/bin/ssh-add -q --apple-load-keychain || /usr/bin/ssh-add --apple-use-keychain
            ;;
        linux*)
            ## Start ssh-agent with keychain.
            if (( ${+commands[keychain]} )); then
                eval $(keychain --eval --absolute --dir ${XDG_RUNTIME_DIR}keychain --agents ssh id_ed25519 id_ecdsa)
            elif (( ${+commands[ssh-agent]} )) && (( -! $+SSH_AUTH_SOCK )); then
                exec ssh-agent ${SHELL}
            fi
            ;;
    esac
fi
