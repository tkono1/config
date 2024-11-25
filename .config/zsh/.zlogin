case ${OSTYPE} in
    darwin*)
        ## Load SSH keys from Keychain.
        if [ -x /usr/bin/ssh-add ]; then
            if ls ${HOME}/.ssh | grep -q 'id_*'; then
                /usr/bin/ssh-add -q --apple-load-keychain || /usr/bin/ssh-add --apple-use-keychain
            fi
        fi
        ;;
    linux*)
        ## Start ssh-agent.
        if (( ${+commands[ssh-agent]} )) && (( -! $+SSH_AUTH_SOCK )); then
            exec ssh-agent ${SHELL}
        fi
        ;;
esac
