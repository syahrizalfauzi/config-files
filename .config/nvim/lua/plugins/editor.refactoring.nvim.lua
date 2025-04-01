---@module 'lazy'
---@type LazySpec
return {
  "ThePrimeagen/refactoring.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  keys = {
    {
      "<leader>rp",
      function()
        require("refactoring").debug.print_var({ normal = true })
      end,
      desc = "Debug Print Variable",
    },
    {
      "<leader>rc",
      function()
        require("refactoring").debug.cleanup({})
      end,
      desc = "Debug Cleanup",
    },
  },
  lazy = false,
  config = function()
    require("refactoring").setup()
  end,
}
