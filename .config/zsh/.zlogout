case ${OSTYPE} in
    darwin*)
        ;;
    linux*)
        ## Kill user's ssh-agent process.
        if [ $SSH_AGENT_PID ]; then
            eval `ssh-agent -k` > /dev/null 2>&1
        fi
        ;;
esac
