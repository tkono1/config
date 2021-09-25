case ${OSTYPE} in
    darwin*)
    ## Import SSH keys from Keychain.
        if (( $+commands[/usr/bin/ssh-add] )); then
            /usr/bin/ssh-add -A > /dev/null 2>&1
        fi
        ;;
    linux*)
    ## Start ssh-agent.
        #if (( $+commands[ssh-agent] )) && [ -z ${SSH_AGENT_PID} ] && ls ${HOME}/.ssh | grep -q 'id_'; then
        if (( $+commands[ssh-agent] )) && [ -z ${SSH_AGENT_PID} ]; then
            if ls ${HOME}/.ssh | grep -q 'id_'; then
                exec ssh-agent zsh
            fi
        fi
        ;;
esac
