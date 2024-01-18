return {
    "rose-pine/neovim",
    priority = 1000,
    lazy = false,
    config = function()
        require('rose-pine').setup({
            styles = {
                italic = false,
            },
            highlight_groups = {
                -- Hop Theme
                HopNextKey = { bg = "base" }, -- Highlight used for the mono-sequence keys (i.e. sequence of 1)
                HopNextKey1 = { bg = "base" }, -- Highlight used for the first key in a sequence.
                HopNextKey2 = { bg = "base" }, -- Highlight used for the second and remaining keys in a sequence.
                HopUnmatched = { bg = "base" }, -- Highlight used for unmatched part of the buffer when running a Hop command Lua functions.
                HopCursor = { bg = "base" }, -- Highlight used for the fake cursor visible when running a Hop command Lua functions.
                HopPreview = { bg = "base" }, -- Highlight used for to preview the hint for HopPattern.

                -- Telescope Theme
                -- https://github.com/rose-pine/neovim/wiki/Recipes#transparent-telescopenvim
                TelescopeBorder = { fg = "highlight_high", bg = "none" },
                TelescopeResultsNormal = { fg = "subtle", bg = "none" },
                TelescopeSelection = { fg = "text", bg = "base" },
                TelescopeSelectionCaret = { fg = "rose", bg = "rose" },

                -- Syntax preferences
                ["@constructor"] = { fg = "subtle" },
                ["@field"] = { fg = "text" },
            },
        })

        vim.cmd.colorscheme "rose-pine-moon"

        -- highlight current line number
        vim.cmd [[highlight CursorLine cterm=NONE ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE]]
        vim.opt.cursorline = true

        -- fix for TelescopeNormal background not updating from highlight_groups above
        vim.api.nvim_set_hl(0, "TelescopeNormal", {bg="none"})
    end
}
