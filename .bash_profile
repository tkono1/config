if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# For MacPorts.
if [ -d /opt/local/bin ]; then
    export PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
