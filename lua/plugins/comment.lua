-- TODO: make this work better
return {
    {
        "terrortylor/nvim-comment",
        config = function()
            require("nvim_comment").setup({
                create_mappings = false,
            })
            vim.keymap.set({ "n", "v" }, "<leader>c", ":CommentToggle<cr>", { noremap = true, silent = true })
        end,
    },
}
