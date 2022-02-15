-- General settings {{
vim.opt.mouse = ''
vim.opt.swapfile = false

-- Set python location.
if vim.fn.has('macunix') == 1 then
    vim.g.python3_host_prog = '/usr/local/bin/python3'
elseif vim.fn.has('unix') == 1 then
    vim.g.python3_host_prog = '/usr/bin/python3'
end

-- Disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
--- }}

--- vim-plug {{
-- curl -fLo ${XDG_DATA_HOME}/nvim/site/autoload/plug.vim --create-dirs      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
-- PlugInstall [name ...] : Install plugins.
-- PlugUpdate [name ...] : Install or update plugins.
-- PlugUpgrade : Update vim-plug itself.
-- PlugClean : Remove unlisted plugins.
local Plug = vim.fn['plug#']
vim.call('plug#begin')
Plug('arcticicestudio/nord-vim')
Plug('nvim-lualine/lualine.nvim')
Plug('nvim-treesitter/nvim-treesitter', {['do'] = ':TSUpdate'})
vim.call('plug#end')
--- }}

--- Language and encoding settings {{
-- Set the character encoding used inside vim.
vim.opt.encoding = 'utf-8'

if vim.fn.has('unix') == 1 then
    vim.opt.fileformat = 'unix'
    vim.opt.fileformats = {'unix', 'dos', 'mac'}
    vim.opt.fileencodings = {'utf-8', 'cp932', 'euc-jp', 'latin'}
elseif vim.fn.has('win32') == 1 then
    vim.opt.fileformat = 'dos'
    vim.opt.fileformats = {'dos', 'unix', 'mac'}
    vim.opt.fileencodings = {'utf-8', 'euc-jp', 'cp932', 'latin'}
end

-- Treat East Asian Width class as ambiguous.
vim.opt.ambiwidth = 'double'
--- }}

--- Color scheme settings {{
-- 24-bit color settings.
if vim.fn.has('termguicolors') and vim.env.COLORTERM == 'truecolor' then
    vim.opt.termguicolors = true
    vim.opt.cursorline = true
    --vim.opt.list =  tue
    if vim.env.TMUX ~= nill then
        vim.cmd [[let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"]]
        vim.cmd [[let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"]]
    end
end

-- Set background scheme. Set this option before syntax highlighting.
vim.opt.background = 'dark'

-- Nord scheme options.
vim.g.nord_cursor_line_number_background = 1
vim.g.nord_italic = 1
vim.g.nord_italic_comments = 1
vim.g.nord_underline = 1
vim.g.nord_uniform_diff_background = 1
vim.g.nord_bold_vertical_split_line = 1

-- Set color scheme.
vim.cmd [[colorscheme nord]]
--- }}

--- Search settings {{
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.hlsearch = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.wildmenu = true
vim.opt.wildmode = 'list:full'
--- }}

--- Tab settings {{
-- Insert spaces instead of tab.
vim.bo.expandtab = true

-- Tab width.
vim.bo.tabstop = 4

-- Set how many spaces are entered when press tab key.
vim.bo.softtabstop = 4

-- Width of indent when insert mode.
vim.bo.shiftwidth = 4

-- Round indent to multiple of shiftwidth.
vim.opt.shiftround = true

-- Disable auto indent.
vim.bo.autoindent = false
vim.bo.smartindent = false
vim.bo.cindent = false
vim.bo.indentexpr = ''
vim.cmd [[filetype indent off]]
--- }}

--- Edit settings {{
-- Disable insert comment automatically.
vim.cmd [[autocmd FileType * setlocal formatoptions-=cro]]

-- Share clipboard with OS.
vim.opt.clipboard:append('unnamedplus')

-- Keep all windows size as same when add/remove.
vim.opt.equalalways = true
--- }}

--- Display settings {{
-- Show line number.
vim.wo.number = true

-- Show the line and column number of the cursor psition.
vim.opt.ruler = true

-- Show invisible characters
vim.opt.listchars = 'tab:<->', 'space:.', 'eol:↲'

-- Set title of the window to the value of titlestring.
vim.opt.title = false

-- Line longer than the width of the window will wrap.
vim.wo.wrap = true

-- Every wrapped line will continue visually indented.
vim.wo.breakindent = true

-- Disable visual bells.
vim.opt.errorbells = false
vim.opt.visualbell = false
--- }}

--- Syntax settings {{
-- nvim-treesitter
-- TSUpdate {language} : Update modules.
-- TSModuleInfo : list information about modules state.
require('nvim-treesitter.configs').setup {
    ensure_installed = "maintained",
    highlight = {
        enable = true,
    },
}
--- }}

--- Statusline settings {{
-- Always shows status line.
vim.opt.laststatus = 2

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
--- }}
