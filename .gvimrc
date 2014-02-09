if has('gui_running')
    "" Window settings {{{
    " Disable toolbar
    set guioptions-=T

    " Set window size
    set lines=50
    set columns=80

    " When to use a tab pages line.
    " 0: never. 1: only if there are at least two tab pages. 2: always.
    set showtabline=2
    " }}}

    "" Cursor settings {{{
    " n-v-c: normal mode, visual selection mode and command mode.
    " i: insert mode.
    set guicursor=n-v-c:block-Cursor-blinkon0
    set guicursor+=i:ver25-Cursor-blinkwait175
    " }}}

    "" IM settings {{{
    " Disable IM after startup insert mode
    if has('multi_byte_ime') || has('xim') || has('gui_macvim')
        set iminsert=0
        set imsearch=0
        " IM color settings.
        highlight Cursor guifg=NONE guibg=Black
        highlight CursorIM guifg=NONE guibg=Purple
    endif
    " }}}

    "" Font settings {{{
    if has('win32') || has('win64')
        set guifont=Consolas:h10,Lucida_Console:h10:w5
        set guifontwide=MS_Gothic:h9
    elseif has('gui_gtk2')
        set guifont=Inconsolata\ Medium\ 12,Monospace\ Regular\ 10
        set guifontwide=IPAGothic\ Regular\ 12
    elseif has('gui_macvim')
        set guifont=Menlo\ Regular:h12
        "set guifontwide=Osaka\ Regular-Mono:h12
        set guifontwide=Osaka-Mono:h12
        set antialias
    endif
    " }}}
endif
