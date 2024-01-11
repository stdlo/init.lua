-- [[ windows options
vim.o.shell = "powershell"
vim.o.shellcmdflag = "-command"
vim.o.shellquote = ""
vim.o.shellxquote = ""
-- set shell=powershell
-- set shellcmdflag=-command
-- set shellquote=\"
-- set shellxquote=
--

-- [[ maps and opts TODO: organize later ]]
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = ""
-- vim.o.relativenumber = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.completeopt = "menuone,noselect"
vim.o.smartindent = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.updatetime = 50
-- spaces over tabs
vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true


-- [[ maps ]]
vim.keymap.set({ "n", "v" }, "<space>", "<nop>", { noremap = true, silent=true })
vim.keymap.set({ "n", "v" }, "<c-r>", "<nop>", { noremap = true, silent=true })
vim.keymap.set("n", "<leader>E", vim.cmd.Ex)
vim.keymap.set("n", "gh", "0", { silent = true, desc = "" })
vim.keymap.set("n", "gl", "$", { silent = true, desc = "" })
vim.keymap.set("n", "gs", "^", { silent = true, desc = "[g]o to first non-whitespace character of the line" })
vim.keymap.set("n", "ga", ":b#<cr>", { silent = true, desc = "[g]o to last accessed file" })
vim.keymap.set("n", "U", "<c-r>", { silent = true })

-- ex mode emacs binds (should be default everywhere
local ex_opts = { noremap = true, silent = true }
vim.keymap.set("c", "<c-a>", "<home>", ex_opts)
vim.keymap.set("c", "<c-e>", "<end>", ex_opts)
vim.keymap.set("c", "<c-b>", "<left>", ex_opts)
vim.keymap.set("c", "<c-f>", "<right>", ex_opts)

-- [[ plugin configuration ]]
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system {
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  }
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  "ThePrimeagen/vim-be-good",
  -- "tpope/vim-fugitive",
  "tpope/vim-sleuth", -- Detect tabstop and shiftwidth automatically
  {
    -- LSP Configuration & Plugins
    "neovim/nvim-lspconfig",
    dependencies = {
      -- Automatically install LSPs to stdpath for neovim
      { "williamboman/mason.nvim", config = true },
      "williamboman/mason-lspconfig.nvim",

      -- Useful status updates for LSP
      { "j-hui/fidget.nvim", opts = {} },

      -- Additional lua configuration, makes nvim stuff amazing!
      "folke/neodev.nvim",
    },
  },

  {
    -- Autocompletion
    "hrsh7th/nvim-cmp",
    dependencies = {
      -- Snippet Engine & its associated nvim-cmp source
      "L3MON4D3/LuaSnip",
      "saadparwaiz1/cmp_luasnip",

      -- Adds LSP completion capabilities
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-path",

      -- Adds a number of user-friendly snippets
      "rafamadriz/friendly-snippets",
    },
  },

  { 
    "phaazon/hop.nvim",
    branch = 'v2',
    config = function()
      require("hop").setup()
      vim.keymap.set({ "n", "v" }, "gw", ":HopWord<cr>", { noremap = true, silent=true, desc = "hop [w]ord mode"})
      vim.keymap.set({ "n", "v" }, "g/", ":HopPattern<cr>", { noremap = true, silent=true, desc = "hop character search mode" })
    end,
  },	

  -- Useful plugin to show you pending keybinds.
  { 
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
      vim.o.timeoutlen = 200
    end,
    opts = {},
  },
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

  {
    "rose-pine/neovim",
    priority = 1000,
    config = function()
      require('rose-pine').setup({
        styles = {
          italic = false,
        },
        highlight_groups = {
          HopNextKey = { bg = "base" }, -- Highlight used for the mono-sequence keys (i.e. sequence of 1)
          HopNextKey1 = { bg = "base" }, -- Highlight used for the first key in a sequence.
          HopNextKey2 = { bg = "base" }, -- Highlight used for the second and remaining keys in a sequence.
          HopUnmatched = { bg = "base" }, -- Highlight used for unmatched part of the buffer when running a Hop command Lua functions.
          HopCursor = { bg = "base" }, -- Highlight used for the fake cursor visible when running a Hop command Lua functions.
          HopPreview = { bg = "base" }, -- Highlight used for to preview the hint for HopPattern.
          -- TODO: maybe someday https://github.com/rose-pine/neovim/wiki/Recipes#transparent-telescopenvim
        },
      })
      vim.cmd.colorscheme "rose-pine-moon"
    end,
  },

  { 
    "terrortylor/nvim-comment",
    config = function()
      require("nvim_comment").setup({
        create_mappings = false,
      })
      vim.keymap.set({ "n", "v" }, "<leader>c", ":CommentToggle<cr>", { noremap = true, silent=true })
    end,
  },

  -- Fuzzy Finder (files, lsp, etc)
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
  },

  {
    -- Highlight, edit, and navigate code
    "nvim-treesitter/nvim-treesitter",
    dependencies = {
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
  },
}, {})

-- [[ Configure Telescope ]]
require('telescope').setup {
  defaults = {
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
    multi_icon = '',
    results_title = false,
    prompt_title = false,
    title = false,
    sorting_strategy = "ascending",

    layout_config = {
      prompt_position = "top",
    },
    pickers = {
      find_files = {
        prompt_title = "",
        title = "no",
      },
    },
  },
}

pcall(require('telescope').load_extension, 'fzf')

vim.keymap.set('n', '<leader>sro', require('telescope.builtin').oldfiles, { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>b', require('telescope.builtin').buffers, { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', function()
  require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
    winblend = 10,
    previewer = false,
  })
end, { desc = '[/] Fuzzily search in current buffer' })

local function telescope_live_grep_open_files()
  require('telescope.builtin').live_grep {
    grep_open_files = true,
    prompt_title = 'Live Grep in Open Files',
  }
end
-- vim.keymap.set('n', '<leader>', require('telescope.builtin').builtin, { desc = '[S]earch [S]elect Telescope' })
vim.keymap.set('n', '<leader>F', require('telescope.builtin').git_files, { desc = 'Search [G]it [F]iles' })
vim.keymap.set('n', '<leader>f', require('telescope.builtin').find_files, { desc = '[S]earch [F]iles' })

-- Emulate Helix multiple cursor selections
vim.keymap.set("v", "s", function()
    return string.format(":s/%s/%s/g", vim.fn.input("Substitute: "), vim.fn.input("With: "))
end, { expr = true })
