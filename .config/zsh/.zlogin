case ${OSTYPE} in
    darwin*)
    ## Import SSH keys from Keychain.
        if (( $+commands[/usr/bin/ssh-add] )); then
            if ls ${HOME}/.ssh | grep -q 'id_*'; then
                /usr/bin/ssh-add -A > /dev/null
            fi
        fi
        ;;
    linux*)
    ## Start ssh-agent.
        if (( $+commands[ssh-agent] )) && [ -z ${SSH_AGENT_PID} ]; then
            if ls ${HOME}/.ssh | grep -q 'id_*'; then
                exec ssh-agent zsh
            fi
        fi
        ;;
esac
