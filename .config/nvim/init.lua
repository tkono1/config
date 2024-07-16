--- General settings {{
-- Enable lua module loader if available.
if vim.loader then
    vim.loader.enable()
end

-- 
vim.opt.mouse = ''
vim.bo.swapfile = false

-- Set python3 path.
local handle = io.popen('echo $(which python3)')
local python3_path = handle:read('*all')
handle:close()
vim.g.python3_host_prog = python3_path:gsub('\n[^\n]*$', '')

-- Check if node exists.
local handle = io.popen('which node > /dev/null 2>&1;echo $?')
local node_exists = handle:read('*all')
handle:close()
node_exists = node_exists:gsub('\n[^\n]*$', '')

-- Disable unused providers
vim.g.loaded_ruby_provider = 0
if node_exists == '1' then
    vim.g.loaded_node_provider = 0
end
vim.g.loaded_perl_provider = 0
--- }}

--- lazy.nvim {{
local lazypath = vim.fn.stdpath('data')..'/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable",
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

-- :Lazy : Go back to plugin list.
-- :Lazy install : Install missing plugins.
-- :Lazy update : Update plugins.
-- :Lazy clean : Clean plugins that are no longer needed.
require('lazy').setup({
    {"shaunsingh/nord.nvim"},
    {"nvim-lualine/lualine.nvim"},
    {"nvim-treesitter/nvim-treesitter"},
})
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
if vim.fn.has('termguicolors') == 1 and vim.env.COLORTERM == 'truecolor' then
    vim.opt.termguicolors = true
    vim.wo.cursorline = true
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
vim.o.expandtab = true

-- Set number of spaces to be converted to a tab.
vim.o.tabstop = 4

-- Set how many spaces are entered when press tab key.
vim.o.softtabstop = 4

-- Width of indent when insert mode.
vim.o.shiftwidth = 4

-- Round indent to multiple of shiftwidth.
vim.opt.shiftround = true

-- Disable auto indent.
vim.bo.autoindent = false
vim.bo.smartindent = false
vim.bo.cindent = false
vim.bo.indentexpr = ''
vim.cmd.filetype({ "indent", "off" })

-- Disable insert comment automatically.
vim.cmd.filetype({ "plugin", "on" })
vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    command = "setlocal formatoptions-=cro",
})

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
--vim.opt.list = true
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
-- :TSUpdate {language} : Update modules.
-- :TSModuleInfo : list information about modules state.
if type(jit) =='table' then
    require('nvim-treesitter.configs').setup {
        ensure_installed = "all",
        highlight = {
            enable = true,
        },
        indent = {
            enable = true,
        },
    }
end
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
