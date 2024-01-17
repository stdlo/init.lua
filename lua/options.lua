-- <space> for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = ""

-- always block cursor
vim.opt.guicursor = ""

vim.opt.signcolumn = "yes"
-- vim.opt.statuscolumn = "%l"

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

-- hide as much noise from the commandline as possible
vim.opt.showmode = false
vim.opt.shortmess:append("cFmWI")

-- windows config if you must
if vim.fn.has("win32") then require("win32") end

