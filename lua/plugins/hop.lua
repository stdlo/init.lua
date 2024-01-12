  return { 
    "phaazon/hop.nvim",
    branch = 'v2',
    config = function()
      require("hop").setup()
      vim.keymap.set({ "n", "v" }, "gw", ":HopWord<cr>", { noremap = true, silent=true, desc = "enter hop by word"})
      vim.keymap.set({ "n", "v" }, "g/", ":HopPattern<cr>", { noremap = true, silent=true, desc = "enter hop character search" })
    end,
  }
