---@module 'lazy'
---@type LazySpec
return {
  "ibhagwan/fzf-lua",
  dependencies = { "echasnovski/mini.icons" },
  -- opts = {
  --   files = {
  --     no_ignore = true,
  --   },
  -- },
  keys = {
    {
      "<leader>ff",
      "<cmd>FzfLua files<cr>",
      desc = "[F]ind [f]iles",
    },
    {
      "<leader>fb",
      "<cmd>FzfLua buffers<cr>",
      desc = "[F]ind [b]uffers",
    },
    {
      "<leader>fw",
      "<cmd>FzfLua live_grep<cr>",
      desc = "[F]ind [w]ords",
    },
    {
      "<leader>fr",
      "<cmd>FzfLua resume<cr>",
      desc = "[F]ind [r]esume (redo last find)",
    },
    --TODO: add find all files (no ignore)
  },
}
