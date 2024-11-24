require("lint").linters_by_ft = {
  javascript = { "eslint_d" },
  typescript = { "eslint_d" },
  javascriptreact = { "eslint_d" },
  typescriptreact = { "eslint_d" },
  json = { "eslint_d" },
}

require("lint").linters.eslint.ignore_files = { "*.json" }

vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost" }, {
  callback = function()
    require("lint").try_lint()
    -- Defer the diagnostics check to ensure linting is complete
    -- vim.defer_fn(function()
    --   -- Get updated diagnostics
    --   local diagnostics = vim.diagnostic.get(0)
    --   if #diagnostics > 0 then
    --     vim.notify("Total errors: " .. #diagnostics, "error")
    --   end
    -- end, 1000) -- Delay the check for 200ms (adjustable if needed)
  end,
})
