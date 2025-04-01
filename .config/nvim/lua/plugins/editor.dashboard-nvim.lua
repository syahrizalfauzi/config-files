---@module 'lazy'
---@type LazySpec
return {
  "nvimdev/dashboard-nvim",
  dependencies = {
    "ibhagwan/fzf-lua",
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  opts = {
    theme = "doom",
    shortcut_type = "number",
    config = {
      center = {
        {
          desc = "Files",
          key = "f",
          action = "FzfLua files",
        },
        {
          desc = "Recents",
          key = "r",
          action = "FzfLua oldfiles",
        },
        {
          desc = "Words",
          key = "w",
          action = "FzfLua live_grep",
        },
        {
          desc = "Explorer",
          key = "e",
          action = function()
            require("oil").open_float(nil, {
              preview = {
                horizontal = true,
              },
            })
          end,
        },
        {
          desc = "LazyGit",
          key = "l",
          action = "LazyGit",
        },
        {
          desc = "Quit",
          key = "q",
          action = "qa",
        },
      },
      vertical_center = true,
      packages = { enable = true }, -- show how many plugins neovim loaded
      footer = {},
    },
  },
}
