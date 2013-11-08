if has('gui_running')
    "" Window settings {{{
    " Disable toolbar
    set guioptions-=T
    " Set window size
    set lines=50
    set columns=80
    " Keep all windows are same size when add/remove
    set equalalways
    " When to use a tab pages line.
    " 0: never. 1: only if there are at least two tab pages. 2: always.
    set showtabline=2
    " }}}

    "" Font settings {{{
    if has('win32') || has('win64')
        set guifont=Consolas:h10,Lucida_Console:h10:w5
        set guifontwide=MS_Gothic:h10
    elseif has('gui_gtk2')
        set guifont=Inconsolata\ Medium\ 12,Monospace\ Regular\ 10
        "set guifontwide=
    elseif has('gui_macvim')
        set guifont=Menlo\ Regular:h12
        set guifontwide=Osaka\ Regular-Mono:h12
        set antialias
    endif
    " }}}
endif
