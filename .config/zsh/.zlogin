case ${OSTYPE} in
    darwin*)
    ## Import SSH keys from Keychain.
        if (( $+commands[/usr/bin/ssh-add] )); then
            /usr/bin/ssh-add -A > /dev/null 2>&1
        fi
        ;;
    linux*)
    ## Start ssh-agent.
        if (( $+commands[ssh-agent] )) && [ -z ${SSH_AGENT_PID} ] && egrep -q '\s*ForwardAgent\s+yes$' ${HOME}/.ssh/config; then
            exec ssh-agent zsh
        fi
        ;;
esac
