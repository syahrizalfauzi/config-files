---@module 'lazy'
---@type LazySpec
return {
  "akinsho/toggleterm.nvim",
  version = "*",
  opts = {
    open_mapping = [[<A-i>]],
    direction = "float",
  },
  keys = {
    {
      "<A-i>",
      "<cmd>ToggleTerm<cr>",
      desc = "Toggle terminal",
    },
  },
}
