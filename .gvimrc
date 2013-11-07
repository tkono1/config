scriptencoding utf-8
"language C

" Disable toolbar
set guioptions-=T

"" Set notifications {{{
set noerrorbells
set novisualbell
set visualbell t_vb=
" }}}

"" IM settings {{{
" Disable IM after startup insert mode
if has('multi_byte_ime') || has('xim')
    set iminsert=0 imsearch=0
    if has('xim') && has('GUI_GTK')
        set imactivatekey=C-space
    endif
endif

" IM color settings
if has('multi_byte_ime')
    highlight Cursor guifg=NONE guibg=Black
    highlight CursorIM guifg=NONE guibg=Purple
endif
" }}}

"" Set fonts {{{
if has('win32') || has('win64')
    set guifont=Consolas:h10,Lucida_Console:h10:w5
    set guifontwide=MS_Gothic:h10
endif
" }}}

"" Set window size {{{
set lines=50
set columns=80
" }}}
