## Prompt for Git repository {{
autoload -Uz is-at-least

if is-at-least 4.3.10; then
    autoload -Uz vcs_info
    autoload -Uz add-zsh-hook

    zstyle ':vcs_info:*' enable git
    zstyle ':vcs_info:*' formats "%F{034}%c%u%m[%b]%f"
    zstyle ':vcs_info:*' actionformats '[%b|%a]%u%c%m'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' unstagedstr "%F{088}+"
    zstyle ':vcs_info:git:*' stagedstr "%F{190}~"
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
            hook_com[misc]="(↑${ahead})"
        fi
    }

    precmd () { vcs_info }
    setopt prompt_subst
    RPROMPT=$RPROMPT'${vcs_info_msg_0_}'
fi
## }}
