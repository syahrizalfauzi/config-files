return {
  "ggandor/leap.nvim",
  event = "BufReadPre",
  config = function()
    vim.keymap.set("n", "s", "<Plug>(leap)")
    vim.keymap.set("n", "S", "<Plug>(leap-from-window)")
    vim.keymap.set({ "x", "o" }, "s", "<Plug>(leap)")
    -- vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
  end,
}
