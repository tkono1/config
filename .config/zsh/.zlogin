case ${OSTYPE} in
    darwin*)
    ## Import SSH keys from Keychain.
        if type '/usr/bin/ssh-add' > /dev/null 2>&1; then
            /usr/bin/ssh-add -A > /dev/null 2>&1
        fi
        ;;
    linux*)
    ## Start ssh-agent.
        if type 'ssh-agent' > /dev/null 2>&1 && [ -z ${SSH_AGENT_PID} ]; then
            eval `ssh-agent` > /dev/null 2>&1
        fi
        ;;
esac
