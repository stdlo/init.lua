return {
  'stevearc/oil.nvim',
  opts = {},
  config = function()
    vim.opt.splitright = true
    require("oil").setup {
      -- columns = { "icon" },
      keymaps = {
        ["<C-h>"] = false,
      },
      view_options = {
        show_hidden = true,
      },
    }

    -- Open parent directory in current window
    vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })
  end,
}
