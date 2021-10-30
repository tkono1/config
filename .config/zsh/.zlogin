case ${OSTYPE} in
    darwin*)
        ## Load SSH keys from Keychain.
        if (( $+commands[/usr/bin/ssh-add] )); then
            if ls ${HOME}/.ssh | grep -q 'id_*'; then
                /usr/bin/ssh-add --apple-load-keychain
            fi
        fi
        ;;
    linux*)
        ## Start ssh-agent.
        if (( $+commands[ssh-agent] )) && [ -z ${SSH_AUTH_SOCK} ]; then
            if ls ${HOME}/.ssh | grep -q 'id_*'; then
                exec ssh-agent zsh
            fi
        fi
        ;;
esac
