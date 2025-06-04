return {
    "machakann/vim-sandwich",
    -- "ThePrimeagen/vim-be-good",
    "tpope/vim-sleuth",  -- Detect tabstop and shiftwidth automatically
    -- Highlight todo + more
    { 'folke/todo-comments.nvim', event = 'VimEnter', dependencies = { 'nvim-lua/plenary.nvim' }, opts = { signs = false } },

    -- "tpope/vim-fugitive",
    -- "ii14/neorepl.nvim", -- Lua repl
    -- {
    --     dir = "~/.config/nvim/lua/plugins/local",
    --     -- name = "local-config-plugins",
    --     config = function()
    --         require("init")
    --     end
    -- }
}
