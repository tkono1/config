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
        if ls "${HOME}/.ssh/id_*" > /dev/null 2>&1; then
            if (( $+commands[ssh-agent] )) && (( -! $+SSH_AUTH_SOCK )); then
                ls ${HOME}/.ssh | grep -q 'id_*' && exec ssh-agent zsh
            fi
        fi
        ;;
esac
