---@module 'lazy'
---@type LazySpec
return {
  "stevearc/oil.nvim",
  ---@module 'oil'
  ---@type oil.SetupOpts
  opts = {
    delete_to_trash = true,
    watch_for_changes = true,
    columns = {
      "icon",
      "size",
      "mtime",
    },
    view_options = {
      show_hidden = true,
    },
  },
  dependencies = { { "echasnovski/mini.icons", opts = {} } },
  lazy = false,
  keys = {
    {
      "<leader>e",
      function()
        require("oil").open_float(nil, {
          preview = {
            horizontal = true,
          },
        })
      end,
      desc = "File [e]xplorer",
    },
  },
}
