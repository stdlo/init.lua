return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "williamboman/mason.nvim",
    "williamboman/mason-lspconfig.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "hrsh7th/nvim-cmp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "j-hui/fidget.nvim",
  },
  config = function()
    local cmp = require("cmp")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = vim.tbl_deep_extend(
      "force",
      {},
      vim.lsp.protocol.make_client_capabilities(),
      cmp_lsp.default_capabilities())

    --  This function gets run when an LSP connects to a particular buffer.
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = 'LSP: ' .. desc
        end

        vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
      end

      -- nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
      nmap('<leader>a', vim.lsp.buf.code_action, 'Code [a]ction')

      -- nmap('gd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')
      nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
      nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
      -- nmap('gi', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

      nmap('K', vim.lsp.buf.hover, 'Hover Documentation') -- See `:help K` for why this keymap
      nmap('<C-k>', vim.lsp.buf.signature_help, 'Signature Documentation')


      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(bufnr, "Format",
        function(_) vim.lsp.buf.format() end,
        { desc = 'Format current buffer with LSP' })
      vim.cmd.abbreviate("format", "Format")
      vim.cmd.abbreviate("fmt", "Format")
    end

    require("fidget").setup({})
    require("mason").setup()
    require("mason-lspconfig").setup({
      ensure_installed = {
        "lua_ls",
        "clangd",
        -- "tsserver",
      },
      handlers = {
        function(server_name)
          require("lspconfig")[server_name].setup {
            capabilities = capabilities,
            on_attach = on_attach,
          }
        end,
        -- supress noisy lsp warnings
        ["lua_ls"] = function()
          local lspconfig = require("lspconfig")
          lspconfig.lua_ls.setup {
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim", "it", "describe", "before_each", "after_each" },
                }
              }
            }
          }
        end,
      },
    })

    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
      snippet = {
        expand = function(args)
          require('luasnip').lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-y>'] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' }, -- For luasnip users.
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      float = {
        focusable = false,
        style = "minimal",
        border = "rounded",
        source = "always",
        header = "",
        prefix = "",
      },
    })

    -- this is important, i dont like the lsp coloring, treesitter does it well enough
    -- Turn off syntax highlighting from LSP
    for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
      vim.api.nvim_set_hl(0, group, {})
    end
    --
    -- -- mason-lspconfig requires that these setup functions are called in this order
    -- -- before setting up the servers.
    -- require('mason').setup()
    -- require('mason-lspconfig').setup()
    --
    -- -- Enable the following language servers
    -- --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    -- --
    -- --  Add any additional override configuration in the following tables. They will be passed to
    -- --  the `settings` field of the server config. You must look up that documentation yourself.
    -- --
    -- --  If you want to override the default filetypes that your language server will attach to you can
    -- --  define the property 'filetypes' to the map in question.
    -- local servers = {
    --   clangd = {},
    --   -- gopls = {},
    --   -- pyright = {},
    --   -- rust_analyzer = {},
    --   -- tsserver = {},
    --   -- html = { filetypes = { 'html', 'twig', 'hbs'} },
    --
    --   lua_ls = {
    --     Lua = {
    --       workspace = { checkThirdParty = false },
    --       telemetry = { enable = false },
    --       -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
    --       -- diagnostics = { disable = { 'missing-fields' } },
    --     },
    --   },
    -- }
    --
    -- -- Setup neovim lua configuration
    -- require('neodev').setup()
    --
    -- -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    -- local capabilities = vim.lsp.protocol.make_client_capabilities()
    -- capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
    --
    -- -- Ensure the servers above are installed
    -- local mason_lspconfig = require 'mason-lspconfig'
    --
    -- mason_lspconfig.setup {
    --   ensure_installed = vim.tbl_keys(servers),
    -- }
    --
    -- mason_lspconfig.setup_handlers {
    --   function(server_name)
    --     require('lspconfig')[server_name].setup {
    --       capabilities = capabilities,
    --       on_attach = on_attach,
    --       settings = servers[server_name],
    --       filetypes = (servers[server_name] or {}).filetypes,
    --     }
    --   end,
    -- }
  end
}
