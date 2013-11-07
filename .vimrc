set nocompatible
set backspace=start,eol,indent
set whichwrap=b,s
set mouse=

" Disable bells.
set noerrorbells
set novisualbell
set visualbell t_vb=

"" Encoding settings {{{
" Set the character encoding used inside vim.
set enc=utf-8
" Set the character encoding for the file of this buffer.
set fenc=utf-8
" List of character encodings.
set fencs=iso-2022,utf-8,euc-jp,cp932
"
set ambiwidth=double
" Set script encoding.
scriptencoding utf-8
" }}}

"" Search settings {{{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set wildmenu wildmode=list:full
" }}}

"" Tab settings {{{
" Tab width of file
set tabstop=4
set softtabstop=4
" Width of indent
set shiftwidth=4
set shiftround
" Insert spaces instead of tab
set expandtab
"set autoindent
"set smartindent
" }}}

"" Display settings {{{
" Show line number.
set number
" Show the line and column number of the cursor psition.
set ruler
" Set title of the window to the value of titlestring.
set title
" Line longer than the width of the window will wrap.
set wrap
" Show command in the last line of screen.
set showcmd
" Show current mode.
set showmode
" Show tabs as Ctrl-I.
"set list
"set listchars=tab:^\ ,trail:~
" }}}

"" Statusline settings {{{
" Always shows status line.
set laststatus=2
" Where to truncate line if too long.
set statusline=%<
" Modified flag.
set statusline+=%m
" Full path to the file in the buffer.
set statusline+=%F
" Preview window flag.
set statusline+=%w
" Encoding.
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}:%{&ff}]
" Readonly flag.
set statusline+=%r
" Help buffer flag.
set statusline+=%h
" Separation point between left and right aligned items.
set statusline+=%=
" Line number and column number.
set statusline+=[%l/%LL,%cC]
" }}}

"" Syntax settings {{{
" Enable syntax highlighting.
syntax enable
" Enable file type detection.
filetype on
" Set coloring.
"highlight ctermbg none ctermfg none
"highlight MatchParen ctermfg=none ctermbg=none
" }}}

" Disable auto insert comment.
autocmd FileType * set formatoptions-=ro

"" MacVim settings {{{
if has('gui_macvim')
    " When to use a tab pages line.
    " 0: never. 1: only if there are at least two tab pages. 2: always.
    set showtabline=2
    " Hide toolbar.
    set guioptions-=T
    " Make all windows the same size when adding/removing windows.
    set equalalways
    " Disable IM.
    set imdisable
    " Set antialias.
    set antialias
endif
" }}}
