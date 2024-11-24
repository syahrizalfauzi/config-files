local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettierd" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    typescript = { "prettierd" },
    javascriptreact = { "prettierd" },
    typescriptreact = { "prettierd" },
    json = { "prettierd" },
    go = { "gofmt" },
    php = { "pretty-php" },
    rust = { "rustfmt" },
  },

  -- format_on_save = {
  --   -- These options will be passed to conform.format()
  --   timeout_ms = 500,
  --   lsp_fallback = true,
  -- },
}

-- Variable to track whether formatting is enabled
local format_on_save_enabled = true

-- Function to toggle formatting on save
local function toggle_format_on_save()
  format_on_save_enabled = not format_on_save_enabled
  if format_on_save_enabled then
    print "Formatting on save is enabled."
  else
    print "Formatting on save is disabled."
  end
end

vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function(args)
    if format_on_save_enabled then
      require("conform").format { bufnr = args.buf }
    end
  end,
})

vim.api.nvim_create_user_command("ToggleFormatOnSave", toggle_format_on_save, {})

return options
