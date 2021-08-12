## SSH Import keys from Keychain.   
if type '/usr/bin/ssh-add' > /dev/null 2>&1; then
    /usr/bin/ssh-add -A
fi
