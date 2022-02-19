-- General settings {{
vim.opt.mouse = ''
vim.bo.swapfile = false

-- Set python3 path.
local handle = io.popen('echo $(which python3)')
local python3_path = handle:read('*all')
handle:close()
vim.g.python3_host_prog = python3_path:gsub('\n[^\n]*$', '')

-- Disable unused providers
vim.g.loaded_python_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_node_provider = 0
vim.g.loaded_perl_provider = 0
--- }}

--- packer.nvim {{
-- git clone --depth 1 https://github.com/wbthomason/packer.nvim                   ~/.local/share/nvim/site/pack/packer/start/packer.nvim
-- PackerCompile : Regenerate compiled loader file
-- PackerClean : Remove any disabled or unused plugins
-- PackerInstall : Clean, then install missing plugins
-- PackerUpdate : Clean, then update and install plugins
-- PackerSync : Perform `PackerUpdate` and then `PackerCompile`
require('packer').startup(function()
    use {'wbthomason/packer.nvim'}
    use {'shaunsingh/nord.nvim'}
    use {'nvim-lualine/lualine.nvim'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
end)
--- }}

--- Language and encoding settings {{
-- Set the character encoding used inside vim.
vim.opt.encoding = 'utf-8'

if vim.fn.has('unix') == 1 then
    vim.bo.fileformat = 'unix'
    vim.opt.fileformats = {'unix', 'dos', 'mac'}
    vim.opt.fileencodings = {'utf-8', 'cp932', 'euc-jp'}
elseif vim.fn.has('win32') == 1 then
    vim.bo.fileformat = 'dos'
    vim.opt.fileformats = {'dos', 'unix', 'mac'}
    vim.opt.fileencodings = {'utf-8', 'cp932', 'euc-jp'}
end

-- Treat East Asian Width class as ambiguous.
vim.opt.ambiwidth = 'double'
--- }}

--- Color scheme settings {{
-- 24-bit color settings.
if vim.fn.has('termguicolors') and vim.env.COLORTERM == 'truecolor' then
    vim.opt.termguicolors = true
    vim.wo.cursorline = true
    --vim.opt.list =  tue
end

-- Set background scheme. Set this option before syntax highlighting.
vim.opt.background = 'dark'

-- nord.nvim scheme options.
vim.g.nord_borders = true
vim.g.nord_italic = true

-- Set color scheme.
require('nord').set()
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
        component_separators = {left = ' ', right = ''},
        section_separators = {left = '', right = ''},
    },
    sections = {
        lualine_a = {'mode'},
        lualine_b = {{'filename', path = 1, shorting_target = 0}},
        lualine_c = {''},
        lualine_x = {
            'encoding',
            {
                'fileformat',
                icons_enabled = true,
                symbols = {unix = 'LF', dos = 'CRLF', mac = 'CR'}
            }
        },
        lualine_y = {'filetype'},
        lualine_z = {'%l/%LL'},
    },
}

-- Hide current mode if lualine.nvim is set.
vim.opt.showmode = false
--- }}
