return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view = {
      side = "right",
      adaptive_size = true,
      number = true,
    },
    filters = {
      dotfiles = false,
      git_ignored = false,
    },
    renderer = {
      highlight_opened_files = "all",
    },
  },
}
