vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { noremap = true, silent=true })
vim.keymap.set({ "n", "v" }, "<c-r>", "<nop>", { noremap = true, silent=true })
vim.keymap.set("n", "<leader>E", vim.cmd.Ex)
vim.keymap.set("n", "gh", "0", { silent = true, desc = "go to the start of the line" })
vim.keymap.set("n", "gl", "$", { silent = true, desc = "go to the end of the line" })
vim.keymap.set("n", "gs", "^", { silent = true, desc = "go to the first non-whitespace character of the line" })
vim.keymap.set("n", "ga", ":b#<cr>", { silent = true, desc = "go to the last accessed buffer" })
vim.keymap.set("n", "U", "<c-r>", { silent = true, desc = "redo" })

-- ex mode emacs binds, TODO: fix cursor not updating on movement
vim.keymap.set("c", "<c-a>", "<home>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-e>", "<end>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-b>", "<left>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-f>", "<right>", { noremap = true, silent = true })
