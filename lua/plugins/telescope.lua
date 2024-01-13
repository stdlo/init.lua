return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make", cond = function() return vim.fn.executable "make" == 1 end },
  },
  opts = {
    defaults = {
      mappings = {
        i = {
          ["<tab>"] = function(...) return require("telescope.actions").move_selection_next(...) end,
          ["<s-tab>"] = function(...) return require("telescope.actions").move_selection_previous(...) end,
          ["<esc>"] = function(...) return require("telescope.actions").close(...) end,

          -- TODO: fix error when initially toggling it doesnt have a buffer to highlight
          -- change theme when doing this? or maybe move the preview window
          ["<c-t>"] = function(...) return require("telescope.actions.layout").toggle_preview(...) end,
        },
        n = {
          ["<c-c>"] = function(...) return require("telescope.actions").close(...) end,
        },
      },
      sorting_strategy = "ascending",
      layout_config = {
        prompt_position = "top",
        height = 0.6,
        width = 0.7,
      },
    },
    pickers = {
      buffers =  {
        theme = "dropdown",
        previewer = false,
        prompt_title = false
      },
      git_files =  {
        theme = "dropdown",
        previewer = false,
        prompt_title = false
      },
      find_files =  {
        theme = "dropdown",
        previewer = false,
        prompt_title = false
      },
      live_grep = {
        theme = "ivy",
        previewer = true,
        prompt_title = false,
        results_title = false,
        preview_title = false,
        prompt_prefix = "/",
        borderchars = {
          preview = { "", "", "", "│", "", "", "", "" }
        },
      },
    },
  },
  keys = {
    { "<leader>f", "<cmd>Telescope find_files<cr>",  desc = "Find files from current directory" },
    { "<leader>?", "<cmd>Telescope keymaps<cr>",  desc = "Find files from current directory" },
    { "<leader>b", "<cmd>Telescope buffers<cr>",  desc = "Find existing buffers" },
    { "<leader>F", "<cmd>Telescope git_files<cr>",  desc = "Find files tracked by git" },
    { "<leader>/", "<cmd>Telescope live_grep<cr>",  desc = "Global grep search" },
  },
  config = function(_, opts)
    require("telescope").setup(opts)
    require("telescope").load_extension("fzf")
  end,
}
