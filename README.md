# nvim

## Setup
Needs:
- Neovim 0.12 or later
- git, for lazy.nvim to install the plugins
- [tree-sitter-cli](https://github.com/tree-sitter/tree-sitter/blob/master/crates/cli/README.md) 0.26.1 or later
  and a C compiler, for nvim-treesitter to build parsers (`brew install tree-sitter-cli` on macOS; not the npm package)
- make and a C compiler for telescope-fzf-native (optional: telescope works without it)

Clone into `~/.config/nvim` (`~/AppData/Local/nvim` on Windows) and start nvim: lazy.nvim installs the plugins
and mason installs the language servers. `lazy-lock.json` pins the plugin versions; `:Lazy update` moves them.

Coming from nvim-treesitter's old master branch: delete `~/.local/share/nvim/lazy/nvim-treesitter` once, so
parsers built for master don't linger, then start nvim and let it reinstall.

## Godot on WSL
This was a pain to setup for wsl but I got it working
(`after/ftplugin/gdscript.lua` connects to Godot's LSP and opens the `/tmp/godot.pipe` server).

I tried godot-wsl-lsp and it seemed to obsfucate what was happening. It was
unclear how I was supposed to configure godot to work with it.

There's a cmd script for the windows side (it may be worth writing and
compiling something for this):
```cmd
@echo off
wsl wslpath "%~f1" > tmpfile
set /p filepath= < tmpfile
del tmpfile
wsl -e sh -lic nvim --server "/tmp/godot.pipe" --remote-send "<esc>:n %filepath%<CR>:call cursor(%2,%3)<CR>"
```

Godot should execute that for the external editor. Flags: `{file} {line} {col}`

WSL 2.0 needs to be configured, in `%UserProfile%\.wslconfig`:
```
[wsl2]
networkingMode=mirrored
```

Useful links, wsl specific:
- https://gist.github.com/lucasecdb/2baf6d328a10d7fea9ec085d868923a0
- https://damopewpew.github.io/nvim/wsl/godot/unity3d/vim/2020/02/29/wsl-nvim-as-external-editor.html
- https://github.com/lucasecdb/godot-wsl-lsp
- https://github.com/cgsdev0/godot-lsp-wsl

godot on windows in general:
- https://mb-izzo.github.io/nvim-godot-solution/
- https://www.reddit.com/r/neovim/comments/13ski66/neovim_configuration_for_godot_4_lsp_as_simple_as/

## Todo
plugins
- [ ] configure telescope
- [ ] multiline f and t
- [ ] god ^c

low priority
- [ ] harpoon
- [ ] treesitter
- [ ] autoformat
