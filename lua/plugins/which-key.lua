return {
    { 
        "folke/which-key.nvim",
        event = "VeryLazy",
        init = function()
            vim.opt.timeoutlen = 200
        end,
        opts = {},
    },
}
