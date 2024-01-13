-- statusline
vim.cmd.highlight({ "mode_ins", "guifg=#ea9a97 guibg=#2a273f" }) -- rose
vim.cmd.highlight({ "mode_vis", "guifg=#c4a7e7 guibg=#2a273f" }) -- iris
vim.cmd.highlight({ "mode_cmd", "guifg=#9ccfd8 guibg=#2a273f" }) -- foam

-- local function color(hl, str, next_hl) return string.format("%%#%s#%s%%#%s#", hl, str, next_hl) end
local current_mode = {
    n = "NOR",
    v = "%#mode_vis#VIS%#StatusLine#",
    V = "%#mode_vis#VIL%#StatusLine#",
    i = "%#mode_ins#INS%#StatusLine#",
    c = "%#mode_cmd#CMD%#StatusLine#",
}
local make_statusline = function()
    local mode = current_mode[vim.fn.mode()]
    return string.format(" %s %%f %%m %%= %%l:%%c ♥ ", mode)
end

vim.api.nvim_create_autocmd("ModeChanged", {
    pattern = "*:*",
    callback = function() vim.opt.statusline = make_statusline() end
})

vim.opt.statusline = make_statusline()

return {} -- trick lazy into loading this file
