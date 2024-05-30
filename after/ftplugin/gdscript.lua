local port = os.getenv('GDScript_Port') or '6005'
-- linux
-- local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
-- local pipe = '/path/to/godot.pipe' -- I use /tmp/godot.pipe

-- windows
-- editor config
-- Exec Path: D:\Apps\Neovim\bin\nvim.exe
-- Exec Flags: --server "\\\\.\\pipe\\godot.pipe" --remote-send "<C-\><C-N>:n {file}<CR>:call cursor({line},{col})<CR>"
local cmd = {'nc', '127.0.0.1', port}
local pipe = [[\\.\pipe\godot.pipe]]

-- tabs over spaces, gdscript convention
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.lsp.start({
  name = 'Godot',
  cmd = cmd,
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, { upward = true })[1]),
  on_attach = function(client, bufnr)
    vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  end
})

-- ref: https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
vim.keymap.set("n", "K",
  function()
    local path = '"C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe" '
    local keyword = vim.fn.expand("<cword>")
    local url = '"https://docs.godotengine.org/en/stable/search.html?q=' .. keyword .. '&check_keywords=yes"'
    local command = "!start " .. path .. url
    vim.cmd("silent " .. command)
  end,
  { silent = true }
)
