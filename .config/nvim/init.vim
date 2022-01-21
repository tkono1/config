"" General settings {{
set nocompatible
set backspace=start,eol,indent
set whichwrap=b,s
set mouse=

" Set python location.
let g:python_host_prog=system('echo -n $(which python)')
let g:python3_host_prog=system('echo -n $(which python3)')
"" }}

"" Language and encoding settings {{
" Set language to UTF-8.
if has('multi_lang')
    set langmenu=en_US.UTF-8
    let $LANG="en"
endif

" Set the character encoding used inside vim.
set encoding=utf-8

" Set script encoding.
scriptencoding utf-8

" Set the character encoding for the file of this buffer.
set fileencoding=utf-8

if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencodings=utf-8,iso-2022-jp,cp932,euc-jp,latin
elseif has('win32') || ('win64')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencodings=iso-2022-jp,utf-8,euc-jp,cp932,latin
endif

" Treat East Asian Width class as ambiguous.
set ambiwidth=double
"" }}

"" Color scheme settings {{
" 24-bit color settings.
if has('termguicolors') && $COLORTERM == 'truecolor'
    set termguicolors
    set cursorline
    if &term =~# '^screen' || &term =~# '^tmux'
        let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    endif
endif
"" }}

" Set background scheme. Set this option before syntax highlighting.
set background=dark

" Nord scheme options.
let g:nord_cursor_line_number_background=1
let g:nord_italic=1 
let g:nord_italic_comments=1
let g:nord_underline=1

" Set color scheme.
"colorscheme monokai
colorscheme nord
"" }}

"" Search settings {{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set wildmenu wildmode=list:full
"" }}

"" Tab settings {{
" Tab width of file.
set tabstop=4
set softtabstop=4

" Width of indent.
set shiftwidth=4
set shiftround

" Insert spaces instead of tab.
set expandtab
"" }}

"" Edit settings {{
" Disable insert comment automatically.
set paste

" Share clipboard with OS.
set clipboard+=unnamedplus

" Keep all windows size as same when add/remove.
set equalalways
"" }}

"" Display settings {{
" Enable italic support since terminfo doesn't define the sitm.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Show line number.
set number

" Show the line and column number of the cursor psition.
set ruler

" Set title of the window to the value of titlestring.
set notitle

" Line longer than the width of the window will wrap.
set wrap

" Show command in the last line of screen.
set showcmd

" Show current mode.
set showmode

" Show tabs as Ctrl-I.
"set list
"set listchars=tab:^\ ,trail:~

" Disable visual bells.
set noerrorbells
set novisualbell
set visualbell t_vb=
"" }}

"" Syntax settings {{
" Enable syntax highlighting.
syntax enable

" If you want to overrule your syntax, use below instead.
syntax on

" Enable file type detection.
filetype on
"" }}

"" Statusline settings {{
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

" Filetype in buffer.
set statusline+=%y

" Line number and column number.
set statusline+=[%l/%LL]
"" }}
