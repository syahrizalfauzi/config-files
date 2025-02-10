return {
  "easymotion/vim-easymotion",
  event = "BufReadPre",
  config = function()
    vim.keymap.set("n", "s", "<Plug>(easymotion-s)")
    -- vim.keymap.set("n", "S", "<Plug>(easymotion-overwin-s)")
    vim.keymap.set({ "x", "o" }, "s", "<Plug>(easymotion-s)")
    -- vim.keymap.set({ "x", "o" }, "S", "<Plug>(leap-backward)")
    vim.g.EasyMotion_smartcase = 1
  end,
}
