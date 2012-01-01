## Aliases.
alias ll ls -lAF
if ( -x `which vim` ) then
    alias vi `which vim`
endif

# Set default permission.
umask 22

# Ignore EOF(Ctrl+D).
set     ignoreeof
# 
set     autolist
# Correct mistakes automatically.
set autocorrect
# Set command path (serenv also).
set path = (/sbin /bin /usr/sbin /usr/bin /usr/games /usr/local/sbin /usr/local/bin $HOME/bin)

setenv EDITOR vim
setenv PAGER more
setenv BLOCKSIZE m

setenv PACKAGEROOT ftp://ftp3.jp.freebsd.org

# Limit size of coredump.
limit coredumpsize 0

# Set command prompt.
if ($?prompt) then
        # An interactive shell -- set some stuff up
        set filec
        set history = 1000
        set savehist = 1000
        set mail = (/var/mail/$USER)
        set promptchars = "%#"
        if ( $?tcsh ) then
                bindkey "^W" backward-delete-word
                bindkey -k up history-search-backward
                bindkey -k down history-search-forward

                set prompt = "%{\e[00;34m%}[%n@%m:%~]%{\e[0m%}%# "
        else
                set prompt = "[`id -nu`@%m]%# "
        endif
endif
