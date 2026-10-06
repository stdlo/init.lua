return {
    "machakann/vim-sandwich",
    "tpope/vim-sleuth",  -- Detect tabstop and shiftwidth automatically
    -- Highlight todo + more
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

}
