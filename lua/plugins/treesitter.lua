-- Highlight, indent and navigate code
-- The main branch needs Neovim 0.12+ and tree-sitter-cli (see the README)
local parsers = { 'bash', 'c', 'cpp', 'go', 'gdscript', 'diff', 'html', 'lua', 'luadoc', 'markdown', 'markdown_inline', 'query', 'vim', 'vimdoc', 'rust' }

return {
  'nvim-treesitter/nvim-treesitter',
  branch = 'main',
  lazy = false,
  build = ':TSUpdate',
  config = function()
    local ts = require('nvim-treesitter')
    ts.install(parsers)

    local function attach(buf, lang)
      if not vim.api.nvim_buf_is_valid(buf) or not pcall(vim.treesitter.start, buf, lang) then return end
      if #vim.treesitter.query.get_files(lang, 'indents') > 0 then
        vim.bo[buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
      end
    end

    vim.api.nvim_create_autocmd('FileType', {
      group = vim.api.nvim_create_augroup('my-treesitter', { clear = true }),
      callback = function(event)
        local lang = vim.treesitter.language.get_lang(event.match)
        if not lang then return end
        if vim.treesitter.language.add(lang) then
          attach(event.buf, lang)
        elseif vim.list_contains(ts.get_available(), lang) then
          -- install a missing parser the first time, like auto_install did on the master branch
          ts.install(lang):await(function(err)
            if not err then vim.schedule(function() attach(event.buf, lang) end) end
          end)
        end
      end,
    })
  end,
}
