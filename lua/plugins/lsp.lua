return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",

    -- Useful status updates for LSP.
    { "j-hui/fidget.nvim", opts = {} },

    -- Allows extra capabilities provided by blink.cmp
    "saghen/blink.cmp",
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("my-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end
        map("gd", vim.lsp.buf.definition, "[g]oto [d]efinition")
        map("gD", vim.lsp.buf.declaration, "[g]oto [d]eclaration")
        map("gi", vim.lsp.buf.implementation, "[g]oto [i]mplementation")
        map("gro", vim.diagnostic.open_float, "[g]oto? [r]eference? [o]pen_float")
        local bordered_hover = function(_opts)
          _opts = _opts or {}
          return vim.lsp.buf.hover(vim.tbl_deep_extend("force", _opts, { border = "single" }))
        end
        map("K", bordered_hover, "vim.lsp.buf.hover")

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(event.buf, "Format",
        function(_) vim.lsp.buf.format() end,
        { desc = 'Format current buffer with LSP' })
        end,
    })

    -- :fmt and :format run :Format; command-line only, so typing fmt or format in a file is left alone
    for _, word in ipairs({ "fmt", "format" }) do
      vim.keymap.set("ca", word, function()
        return (vim.fn.getcmdtype() == ":" and vim.fn.getcmdline() == word) and "Format" or word
      end, { expr = true })
    end

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = "single", source = "if_many" },
      underline = { severity = vim.diagnostic.severity.ERROR },
      virtual_text = {
        source = "if_many",
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            -- [vim.diagnostic.severity.WARN] = diagnostic.message,
            -- [vim.diagnostic.severity.INFO] = diagnostic.message,
            -- [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
      clangd = {},
      ts_ls = {},
      lua_ls = {},
    }
    require("mason-tool-installer").setup { ensure_installed = vim.tbl_keys(servers) }
    require("mason-lspconfig").setup {
      ensure_installed = {}, -- explicitly set to an empty table
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          -- This handles overriding only values explicitly passed
          -- by the server configuration above. Useful when disabling
          -- certain features of an LSP (for example, turning off formatting for ts_ls)
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end
}
