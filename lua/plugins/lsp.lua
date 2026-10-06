return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",

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
        -- go to implementation is Neovim's built-in gri
        map("gro", vim.diagnostic.open_float, "Open diagnostic float")
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

    -- mason-lspconfig installs these and enables every installed server with vim.lsp.enable;
    -- blink.cmp adds its completion capabilities to all of them itself.
    -- Per-server settings, when one needs them, go in after/lsp/<server>.lua
    require("mason-lspconfig").setup {
      ensure_installed = { "clangd", "ts_ls", "lua_ls" },
    }
  end
}
