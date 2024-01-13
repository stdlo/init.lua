-- <space> for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = ""

-- always block cursor
vim.opt.guicursor = ""

vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.completeopt = "menuone,noselect"

vim.opt.smartindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- spaces over tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

-- statusline
local current_mode = {
    n = 'NOR',
    v = '%#Macro#VIS%#Subtle#',
    V = 'VIL',
    i = '%#Error#INS%#Subtle#',
    c = 'CMD',
    r = 'RE ',
}
local make_statusline = function()
    local mode = current_mode[vim.fn.mode()]
    return string.format(" %s %%f %%m %%= %%l:%%c ♥ ", mode)
end

vim.api.nvim_create_autocmd('ModeChanged', {
    pattern = '*:*',
    callback = function() vim.opt.statusline = make_statusline() end
})

vim.opt.statusline = make_statusline()

-- hide as much noise from the commandline as possible
vim.opt.showmode = false
vim.opt.shortmess:append("cFmWI")

-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--     callback = function() vim.defer_fn(function() print('') end, 3000) end
-- })

-- windows config if you must
if vim.fn.has("win32") then require("win32") end

