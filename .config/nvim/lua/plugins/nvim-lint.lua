return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "folke/trouble.nvim",
  },
  config = function()
    require "configs.lint"
  end,
}
