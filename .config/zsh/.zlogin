## SSH Import keys from Keychain.   
case ${OSTYPE} in
    darwin*)
        if type '/usr/bin/ssh-add' > /dev/null 2>&1; then
            /usr/bin/ssh-add -A > /dev/null 2>&1
        fi
;;
esac
