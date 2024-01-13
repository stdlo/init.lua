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

--[[
--statusline
vim.cmd.highlight({ "mode_ins", "guifg=#ea9a97 guibg=#2a273f" }) -- rose
vim.cmd.highlight({ "mode_vis", "guifg=#c4a7e7 guibg=#2a273f" }) -- iris
-- vim.cmd.highlight({ "mode_nor", "guifg=#9ccfd8 guibg=#2a273f" })
vim.cmd.highlight({ "mode_cmd", "guifg=#9ccfd8 guibg=#2a273f" })

-- local function color(hl, str, next_hl) return string.format('%%#%s#%s%%#%s#', hl, str, next_hl) end
local current_mode = {
    -- n = '%#mode_nor#NOR%#StatusLine#',
    n = 'NOR',
    v = '%#mode_vis#VIS%#StatusLine#',
    V = '%#mode_vis#VIL%#StatusLine#',
    i = '%#mode_ins#INS%#StatusLine#',
    c = '%#mode_cmd#CMD%#StatusLine#',
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
--]]

-- hide as much noise from the commandline as possible
vim.opt.showmode = false
vim.opt.shortmess:append("cFmWI")

-- vim.api.nvim_create_autocmd('CmdlineLeave', {
--     callback = function() vim.defer_fn(function() print('') end, 3000) end
-- })

-- windows config if you must
if vim.fn.has("win32") then require("win32") end

