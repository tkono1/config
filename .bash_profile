#
## XDG base directories {{
#
# Prepare and export XDG base directories.
[[ ! -d ${HOME}/.config ]] && mkdir ${HOME}/.config
export XDG_CONFIG_HOME=${HOME}/.config

[[ ! -d ${HOME}/.local/share ]] && mkdir -p ${HOME}/.local/share
export XDG_DATA_HOME=${HOME}/.local/share

[[ ! -d ${HOME}/.local/state ]] && mkdir -p ${HOME}/.local/state
export XDG_STATE_HOME=${HOME}/.local/state

[[ ! -d ${HOME}/.cache/ ]] && mkdir ${HOME}/.cache
export XDG_CACHE_HOME=${HOME}/.cache
## }}

#
## Set command path {{
#
# Add path for snap
test -d /snap/bin && export PATH=/snap/bin:${PATH}

# Add a path for local bin.
test -d ${HOME}/.local/bin && export PATH=${HOME}/.local/bin:${PATH}
## }}

#
## Load .bashrc {{
#
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
## }}
