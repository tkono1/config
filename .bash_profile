#
## XDG base directories {{
#
# Prepare and export XDG base directories.
export XDG_CONFIG_HOME="${HOME}/.config" && mkdir -p "${XDG_CONFIG_HOME}"
export XDG_DATA_HOME="${HOME}/.local/share" && mkdir -p "${XDG_DATA_HOME}"
export XDG_STATE_HOME="${HOME}/.local/state" && mkdir -p "${XDG_STATE_HOME}"
export XDG_CACHE_HOME="${HOME}/.cache" && mkdir "${XDG_CACHE_HOME}"
## }}
#
## Load .bashrc {{
#
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
## }}
