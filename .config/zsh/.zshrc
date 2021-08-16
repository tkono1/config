## ZSH configurations.
## You can check zsh options using "set -o" command.

## Language settings {{
export LANG=en_US.UTF-8
## }}

## Load fundamental modules {{
# zsh version check.
autoload -Uz is-at-least
## }}

## Completion {{
# Set auto completion.
autoload -Uz compinit && compinit

# Highlight completion items.
zstyle ':completion:*:default' menu select=2
setopt menu_complete

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
PROMPT="%F{034}[%n@%m%F{012}:%~%F{034}]\$%k%f "
PROMPT2="%F{034}[%_]\$%k%f "
SPROMPT="%F{034}%r is correct? [n,y,a,e]:%k%f "
## }}

## Prompt for Git repository {{
if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    autoload -Uz add-zsh-hook

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' formats "%F{034}%c%u%m[%b]%f"
    zstyle ':vcs_info:*' actionformats '[%b|%a]%u%c%m'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr "%F{088}!"
    zstyle ':vcs_info:git:*' stagedstr "%F{190}+"
    zstyle ':vcs_info:git+set-message:*' hooks git-untracked git-push-status

# Functions for vcs_info with "+vi-" for hiding them from normal use.
    function +vi-git-untracked() {
        if command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' > /dev/null 2>&1; then
        hook_com[unstaged]+='?'
        fi
    }

    function +vi-git-push-status() {
        local master=$(command git branch --contains=HEAD 2> /dev/null \
            | awk '{print $2}')
        if [[ "${hook_com[branch]}" != "${master}" ]]; then
            return 0
        fi
        local ahead=$(command git rev-list origin/${master}..${master} \
            2>/dev/null | wc -l | tr -d ' ')
        if [[ "${ahead}" -gt 0 ]]; then
            hook_com[misc]="(p${ahead})"
        fi
    }

    precmd () { vcs_info }
    setopt prompt_subst
    RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
fi
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
