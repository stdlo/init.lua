--[[
This was a pain to setup for wsl but I got it working.

I tried godot-wsl-lsp and it seemed to obsfucate what was happening. It was
unclear how I was supposed to configure godot to work with it.

# Theres a cmd script for the windows side (it may be worth writing and
compiling something for this)
```cmd
@echo off
wsl wslpath "%~f1" > tmpfile
set /p filepath= < tmpfile
del tmpfile
wsl -e sh -lic nvim --server "/tmp/godot.pipe" --remote-send "<esc>:n %filepath%<CR>:call cursor(%2,%3)<CR>"
```

# Godot should execute that for the external editor. Flags: `{file} {line} {col}`

# WSL 2.0 needs to be configured
```%UserProfile%\.wslconfig
[wsl2]
networkingMode=mirrored
```

# Useful Links
wsl specific
- https://gist.github.com/lucasecdb/2baf6d328a10d7fea9ec085d868923a0
- https://damopewpew.github.io/nvim/wsl/godot/unity3d/vim/2020/02/29/wsl-nvim-as-external-editor.html
- https://github.com/lucasecdb/godot-wsl-lsp
- https://github.com/cgsdev0/godot-lsp-wsl

godot on windows in general
- https://mb-izzo.github.io/nvim-godot-solution/
- https://www.reddit.com/r/neovim/comments/13ski66/neovim_configuration_for_godot_4_lsp_as_simple_as/
]]--
local lspconfig = require("lspconfig")

local port = os.getenv('GDScript_Port') or '6005'
local pipe = '/tmp/godot.pipe'

-- tabs over spaces, gdscript convention
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = false

vim.lsp.start({
  name = 'Godot',
  cmd = vim.lsp.rpc.connect("127.0.0.1", port),
  filetypes = { "gdscript" },
  root_dir = vim.fs.dirname(vim.fs.find({ 'project.godot', '.git' }, {
    upward = true,
    path = vim.fs.dirname(vim.api.nvim_buf_get_name(0))
  })[1]),
  on_attach = function(client, bufnr)
    vim.api.nvim_command('echo serverstart("' .. pipe .. '")')
  end
})
--
-- -- ref: https://stackoverflow.com/questions/9458294/open-url-under-cursor-in-vim-with-browser
-- vim.keymap.set("n", "K",
--   function()
--     local path = '"C:/Program Files/BraveSoftware/Brave-Browser/Application/brave.exe" '
--     local keyword = vim.fn.expand("<cword>")
--     local url = '"https://docs.godotengine.org/en/stable/search.html?q=' .. keyword .. '&check_keywords=yes"'
--     local command = "!start " .. path .. url
--     vim.cmd("silent " .. command)
--   end,
--   { silent = true }
-- )
