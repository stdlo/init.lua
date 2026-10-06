-- Godot's LSP and the pipe Godot opens files through; the WSL setup is in the README
local port = os.getenv('GDScript_Port') or '6005'
local pipe = '/tmp/godot.pipe'

-- tabs over spaces, gdscript convention; opt_local so other buffers keep spaces
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = false

vim.lsp.start({
  name = 'Godot',
  cmd = vim.lsp.rpc.connect("127.0.0.1", port),
  filetypes = { "gdscript" },
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, {
    upward = true,
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  })[1]),
  on_attach = function()
    -- on_attach runs for every .gd buffer, and starting the pipe twice fails
    if not vim.list_contains(vim.fn.serverlist(), pipe) then
      vim.api.nvim_echo({ { vim.fn.serverstart(pipe) } }, false, {})
    end
  end
})
