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
      -- the commands are `:Obsidian tags`, `:Obsidian backlinks`; the old `:ObsidianTags` forms warn at startup
      legacy_commands = false,
      -- the workspace holds repos, not a vault: a save mustn't add an id/aliases/tags block to the top of a file
      frontmatter = { enabled = false },
    },
  },
  {
    'MeanderingProgrammer/render-markdown.nvim',
    ft = 'markdown',
    dependencies = { 'nvim-treesitter/nvim-treesitter' },
    -- no numbered icons on headings, in the text or the sign column; the #s show instead
    opts = { heading = { icons = {}, sign = false } },
  },
}
