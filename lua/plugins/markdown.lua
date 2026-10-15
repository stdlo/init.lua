-- Markdown notes: tags, links and checkboxes from obsidian.nvim, and the rendering from render-markdown.nvim
return {
  {
    'obsidian-nvim/obsidian.nvim',
    version = '*',
    ft = 'markdown',
    opts = {
      workspaces = {
        { name = 'claude', path = '~/claude-workspace' },
      },
      -- render-markdown draws the checkboxes and headings, and the two fight when both do
      ui = { enable = false },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    opts = {},
  },
}
