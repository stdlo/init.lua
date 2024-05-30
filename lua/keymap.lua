vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { noremap = true, silent=true })
vim.keymap.set({ "n", "v" }, "<c-r>", "<nop>", { noremap = true, silent=true })
vim.keymap.set("n", "<leader>E", vim.cmd.Ex)
vim.keymap.set("n", "gh", "0", { silent = true, desc = "go to the start of the line" })
vim.keymap.set("n", "gl", "$", { silent = true, desc = "go to the end of the line" })
vim.keymap.set("n", "gs", "^", { silent = true, desc = "go to the first non-whitespace character of the line" })
vim.keymap.set("n", "ga", ":b#<cr>", { silent = true, desc = "go to the last accessed buffer" })
vim.keymap.set("n", "U", "<c-r>", { silent = true, desc = "redo" })

--
-- vim.keymap.set({ "v" }, "|", 'y: echo system(input("Pipe: "), @")[:-2]:w<cr>')
-- nnoremap gc :execute '!git commit -m "'.input('Enter message: ').'"'<cr>
vim.keymap.set({ "v" }, "|",  function()
    vim.cmd('noau normal! "vy"')
    local command = vim.fn.input("| ")
    vim.cmd("w !" .. command .. " " .. vim.fn.getreg('v'))
    -- print(">>" .. vim.fn.getreg('v') .. "<<")
    -- local r = vim.region(0, vim.fn.getpos("'<"), vim.fn.getpos("'>"), vim.fn.visualmode(), true)
    -- print(r)
    --
    -- local text = ''
    -- local maxcol = vim.v.maxcol
    -- for line, cols in vim.spairs(r) do
    --
    --     local endcol = cols[2] == maxcol and -1 or cols[2]
    --     local chunk = vim.api.nvim_buf_get_text(0, line, cols[1], line, endcol, {})[1]
    --     text = ('%s%s\n'):format(text, chunk)
    -- end
    -- -- vim.print(text, "foobar")
    -- -- 'y: call system(input("Pipe: ") . @")[:-2]<cr>')
end)


-- ex mode emacs binds, TODO: fix cursor not updating on movement
vim.keymap.set("c", "<c-a>", "<home>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-e>", "<end>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-b>", "<left>", { noremap = true, silent = true })
vim.keymap.set("c", "<c-f>", "<right>", { noremap = true, silent = true })
