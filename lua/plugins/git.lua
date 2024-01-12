return {
    -- "tpope/vim-fugitive",
    {
        "lewis6991/gitsigns.nvim",
        opts = {
            -- See `:help gitsigns.txt`
            signs = {
                add = { text = "▍" }, -- + 
                change = { text = "▍" }, -- ~
                delete = { text = "▍" }, -- _
                topdelete = { text = "▍" }, -- ‾
                changedelete = { text = "▍" }, -- ~
            },
        },
    },
}
