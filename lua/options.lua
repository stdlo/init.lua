-- <space> for leader
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.mouse = ""

-- always block cursor
vim.opt.guicursor = ""

-- turn off all diagnostics
-- vim.diagnostic.config({signs=false,underline=true,virtual_text =false})

-- disable continued comment on o and <Enter>
-- autocmd because setting it directly gets overwritten by ftplugin
vim.cmd([[autocmd BufEnter * set formatoptions-=ro]])

-- enable if gitsigns is going to use gutter space
vim.opt.signcolumn = "yes"
-- move linenumber to statuscolumn
-- vim.opt.statuscolumn = "%l"

vim.opt.number = true
-- vim.opt.relativenumber = true

vim.opt.scrolloff = 8

vim.opt.updatetime = 50
vim.opt.termguicolors = true

vim.opt.hlsearch = false
vim.opt.swapfile = false
vim.opt.undofile = true

vim.opt.wrap = false

vim.opt.completeopt = "menuone,noselect"

vim.opt.smartindent = true
vim.opt.ignorecase = true

-- spaces over tabs
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- hide as much noise from the commandline as possible
vim.opt.showmode = false
vim.opt.shortmess:append("cFmWI")

-- windows config if you must
require("win32")

