-- <space> for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.o.mouse = ""

-- always block cursor
vim.o.guicursor = ""

-- disable continued comment on o and <Enter>
-- autocmd because setting it directly gets overwritten by ftplugin
vim.cmd([[autocmd BufEnter * set formatoptions-=ro]])

-- enable if gitsigns is going to use gutter space
vim.o.signcolumn = "yes"
vim.o.number = true
vim.o.relativenumber = true

vim.o.scrolloff = 8

vim.o.updatetime = 50
vim.o.termguicolors = true

vim.o.hlsearch = false
vim.o.swapfile = false
vim.o.undofile = true

vim.o.wrap = false

vim.opt.completeopt = { "menuone", "noselect" }

vim.o.ignorecase = true

-- spaces over tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true

-- hide as much noise from the commandline as possible
vim.o.showmode = false
vim.opt.shortmess:append("cFmWI")

-- windows config if you must
require("win32")
