return {
  "nvim-treesitter/nvim-treesitter",
  event = { "BufReadPre", "BufNewFile" },
  build = ":TSUpdate",
  dependencies = {
    "windwp/nvim-ts-autotag",
    "nvim-treesitter/nvim-treesitter-textobjects",
    "nvim-treesitter/nvim-treesitter-context",
  },
  config = function()
    -- configure for tree-sitter-blade for Laravel Blade syntax
    local parser_config = require "nvim-treesitter.parsers".get_parser_configs()
    parser_config.blade = {
      install_info = {
        url = "https://github.com/EmranMR/tree-sitter-blade",
        files = { "src/parser.c" },
        branch = "main",
      },
      filetype = "blade"
    }

    vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
      pattern = "*.blade.php",
      command = "set filetype=blade",
      group = vim.api.nvim_create_augroup("BladeFiletypeRelated", { clear = true }),
    })

    -- import nvim-treesitter plugin
    local treesitter = require "nvim-treesitter.configs"

    -- configure treesitter
    treesitter.setup { -- enable syntax highlighting
      highlight = {
        enable = true,
      },
      -- enable indentation
      indent = { enable = true },
      -- enable autotagging (w/ nvim-ts-autotag plugin)
      -- autotag = {
      --   enable = true,
      -- },
      -- ensure these language parsers are installed
      ensure_installed = {
        "json",
        "javascript",
        "typescript",
        "tsx",
        "yaml",
        "html",
        "css",
        "prisma",
        "markdown",
        "markdown_inline",
        "svelte",
        "graphql",
        "bash",
        "lua",
        "vim",
        "dockerfile",
        "gitignore",
        "query",
        "vimdoc",
        "c",
        "go",
        "rust",
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<C-space>",
          node_incremental = "<C-space>",
          scope_incremental = false,
          node_decremental = "<bs>",
        },
      },
    }
  end,
}
