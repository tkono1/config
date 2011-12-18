set nocompatible
set backspace=start,eol,indent
set whichwrap=b,s

" Encoding settings
set encoding=utf-8
set ambiwidth=double

" Search settings
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set wildmode=list:full

" Tab settings
set tabstop=4
set shiftwidth=4
set expandtab
set softtabstop=4
"set autoindent
"set smartindent
set shiftround

" Display settings
set number " Show line number.
set ruler " Show the line and column number of the cursor psition.
set title " Set title of the window to the value of titlestring.
set wrap " Line longer than the width of the window will wrap.
set laststatus=2 " Always shows status line.
set statusline=%< " Where to truncate line if too long.
set statusline+=%m " Modified flag.
set statusline+=%F " Full path to the file in the buffer.
set statusline+=%w " Preview window flag.
set statusline+=\ [%{strlen(&fenc)?&fenc:&enc}:%{&ff}] " Encoding.
set statusline+=%r " Readonly flag.
set statusline+=%h " Help buffer flag.
set statusline+=%= " Separation point between left and right aligned items.
set statusline+=[%l/%LL,%cC] " Line number and column number.
set showcmd " Show command in the last line of the screen.
set showmode
set nolist

" Syntax settings
syntax enable
filetype on
