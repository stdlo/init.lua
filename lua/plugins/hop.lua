return {
  -- phaazon/hop.nvim is gone from GitHub; smoka7's fork is the maintained one, same commands
  "smoka7/hop.nvim",
  version = "*",
  config = function()
    require("hop").setup()
    vim.keymap.set({ "n", "v" }, "gw", "<cmd>HopWord<cr>", { noremap = true, silent = true, desc = "enter hop by word" })
    vim.keymap.set({ "n", "v" }, "g/", "<cmd>HopChar1<cr>",
      { noremap = true, silent = true, desc = "enter hop character search" })
  end,
}
