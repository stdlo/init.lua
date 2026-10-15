-- fold on headings with treesitter, all open at first: zM shows the outline, zo opens one
vim.opt_local.foldmethod = 'expr'
vim.opt_local.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
vim.opt_local.foldlevel = 99
