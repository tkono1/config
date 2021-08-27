## ZSH configurations.
## You can check zsh options using "set -o" command.

## Language settings {{
export LANG=en_US.UTF-8
## }}

## Completion {{
# Set auto completion.
autoload -Uz compinit && compinit

# Highlight completion items.
zstyle ':completion:*:default' menu select=2
#setopt menu_complete

# Try to make the completion list smaller.
setopt list_packed

# If a parameter is completed whose content is the name
# of a directory, then add a trailing slash instead of a space.
setopt auto_param_slash

# Files beginning with a . be matched without explicitly specifying the dot.
setopt globdots

# Print eight bit characters literally in completion lists.
setopt print_eight_bit

# Allow comments even in interactive shells
setopt interactive_comments

# Disable beep.
setopt no_beep

# Disable beep when complete list displayed.
setopt nolistbeep
## }}

## Input/Output {{
# Try to correct the spelling of commands.
setopt correct

# Do not exit on end-of-file.
setopt ignore_eof
## }}

## Keybindings {{
# Set emacs-like keybinding.
bindkey -e
## }}

## History {{
# Location of history file.
HISTFILE=${ZDOTDIR}/.zsh_history

# Size of history file.
HISTSIZE=10000
SAVEHIST=10000

# Share command history.
setopt share_history

# Do not enter command lines into the history list
# if they are duplicates of the previous event.
setopt hist_ignore_dups

# If a new command line being added to the history list
# duplicates an older one, the older command is removed.
setopt hist_ignore_all_dups

# Remove command lines from the history list 
# when the first charactoer on the line is a space.
setopt hist_ignore_space

# Remove superfluous blanks from each command line
# being added to the history list.
setopt hist_reduce_blanks
## }}

## Prompt settings {{
PROMPT="%F{034}[%n@%m%F{012}:%~%F{034}]%#%k%f "
PROMPT2="%F{034}[%_]%#%k%f "
SPROMPT="%F{034}%r is correct? [n,y,a,e]:%k%f "
## }}

## git prompt settings {{
autoload -Uz git-prompt.zsh && git-prompt.zsh

ZSH_GIT_PROMPT_FORCE_BLANK=1
ZSH_GIT_PROMPT_SHOW_UPSTREAM="symbol"
ZSH_THEME_GIT_PROMPT_PREFIX="["
ZSH_THEME_GIT_PROMPT_SUFFIX="]"
ZSH_THEME_GIT_PROMPT_SEPARATOR="|"
ZSH_THEME_GIT_PROMPT_DETACHED="%B%F{cyan}:%f%b"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SYMBOL="%B%F{yellow}⟳ %f%b"
ZSH_THEME_GIT_PROMPT_UPSTREAM_PREFIX="%{$fg[red]%}(%{$fg[yellow]%}"
ZSH_THEME_GIT_PROMPT_UPSTREAM_SUFFIX="%F{red})%f"
ZSH_THEME_GIT_PROMPT_BEHIND="↓"
ZSH_THEME_GIT_PROMPT_AHEAD="↑"
ZSH_THEME_GIT_PROMPT_UNMERGED="%F{red}✖%f"
ZSH_THEME_GIT_PROMPT_STAGED="%F{green}●%f"
ZSH_THEME_GIT_PROMPT_UNSTAGED="%F{red}✚%f"
ZSH_THEME_GIT_PROMPT_UNTRACKED="…"
ZSH_THEME_GIT_PROMPT_STASHED="%F{blue}⚑%f"
ZSH_THEME_GIT_PROMPT_CLEAN="%B%F{green}✔%f"

RPROMPT='$(gitprompt)'
## }}

## GPG {{
# Use pinentry TTY. 
if (( $+commands[gpg] )); then
    export GPG_TTY=$(tty)
fi
##}}

## Aliases {{
case ${OSTYPE} in
    darwin*)
        alias ls='ls -G'
        ;;
    linux*)
        alias ls='ls --color=auto'
        ;;
esac
alias ll='ls -lAF'
if (( $+commands[nvim] )); then
    alias vi='nvim'
elif (( $+commands[vim] )); then
    alias vi='vim'
fi
if (( $+commands[screen] )); then
    export SCREENRC=${XDG_CONFIG_HOME}/screen/screenrc
fi
if (( $+commands[tmux] )); then
    alias tmux="tmux -f ${XDG_CONFIG_HOME}/tmux/tmux.conf"
    export TMUX_TMPDIR=/tmp
fi
## }}
