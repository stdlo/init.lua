local port = os.getenv('GDScript_Port') or '6005'
-- linux
-- local cmd = vim.lsp.rpc.connect('127.0.0.1', port)
-- local pipe = '/path/to/godot.pipe' -- I use /tmp/godot.pipe

-- windows
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
