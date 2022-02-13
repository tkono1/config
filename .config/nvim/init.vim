"" General settings {{
set backspace=start,eol,indent
set mouse=
set noswapfile

" Set python location.
let g:python3_host_prog=system('echo -n $(which python3)')
"" }}

"" vim-plug {{
" curl -fLo ${XDG_DATA_HOME}/nvim/site/autoload/plug.vim --create-dirs      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" PlugInstall [name ...] : Install plugins.
" PlugUpdate [name ...] : Install or update plugins.
" PlugUpgrade : Update vim-plug itself.
" PlugClean : Remove unlisted plugins.
call plug#begin()
Plug 'arcticicestudio/nord-vim'
Plug 'nvim-lualine/lualine.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()
"" }}

"" Language and encoding settings {{
" Set the character encoding used inside vim.
set encoding=utf-8

" Set the character encoding for the file of this buffer.
set fileencoding=utf-8

if has('unix')
    set fileformat=unix
    set fileformats=unix,dos,mac
    set fileencodings=utf-8,cp932,euc-jp,latin
elseif has('win32')
    set fileformat=dos
    set fileformats=dos,unix,mac
    set fileencodings=utf-8,euc-jp,cp932,latin
endif

" Treat East Asian Width class as ambiguous.
set ambiwidth=double
"" }}

"" Color scheme settings {{
" 24-bit color settings.
if has('termguicolors') && $COLORTERM == 'truecolor'
    set termguicolors
    set cursorline
    "set list
    if &term =~# '^screen' || &term =~# '^tmux'
        let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
        let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
    endif
endif

" Set background scheme. Set this option before syntax highlighting.
set background=dark

" Nord scheme options.
let g:nord_cursor_line_number_background=1
let g:nord_italic=1
let g:nord_italic_comments=1
let g:nord_underline=1
let g:nord_uniform_diff_background=1
let g:nord_bold_vertical_split_line=1

" Set color scheme.
colorscheme nord
"" }}

"" Search settings {{
set ignorecase
set smartcase
set hlsearch
set incsearch
set wrapscan
set wildmenu
set wildmode=list:full
"" }}

"" Tab settings {{
" Insert spaces instead of tab.
set expandtab

" Tab width.
set tabstop=4

" Set how many spaces are entered when press tab key.
set softtabstop=4

" Width of indent when insert mode.
set shiftwidth=4

" Round indent to multiple of shiftwidth.
set shiftround

" Disable auto indent.
set noautoindent
set nosmartindent
set nocindent
set indentexpr=
filetype indent off
"" }}

"" Edit settings {{
" Disable insert comment automatically.
autocmd FileType * set formatoptions-=cro

" Share clipboard with OS.
set clipboard+=unnamedplus

" Keep all windows size as same when add/remove.
set equalalways
"" }}

"" Display settings {{
" Enable italic support since terminfo doesn't define the sitm.
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"

" Enable undercurl support.
let &t_Cs="\e[4:3m"
let &t_Ce="\e[4:0m"

" Show line number.
set number

" Show the line and column number of the cursor psition.
set ruler

" Show invisible characters
set listchars=tab:<->,space:.,eol:↲

" Set title of the window to the value of titlestring.
set notitle

" Line longer than the width of the window will wrap.
set wrap

" Every wrapped line will continue visually indented.
set breakindent

" Show command in the last line of screen.
set showcmd

" Disable visual bells.
set noerrorbells
set novisualbell
"" }}

"" Syntax settings {{
" Enable syntax highlighting.
syntax enable
"" }}

lua <<EOF
require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
}
EOF

"" Statusline settings {{
lua <<EOF
-- Always shows status line.
vim.opt.laststatus=2

-- Load lualine components.
require('lualine').setup {
    options = {
        icons_enabled = false,
        theme = 'auto',
        component_separators = {left = ' ', right = '|'},
        section_separators = {left = ' ', right = ' '},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {'branch', 'diff', 'diagnostics'},
        lualine_c = {'%f'},
        lualine_x = {'encoding', 'fileformat', 'filetype'},
        lualine_y = {''},
        lualine_z = {'%l/%LL'},
    },
}

-- Hide current mode if lualine.nvim is set.             
vim.opt.showmode = false
EOF
"" }}
