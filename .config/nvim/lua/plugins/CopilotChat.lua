return {
  "CopilotC-Nvim/CopilotChat.nvim",
  lazy = false,
  branch = "canary",
  dependencies = {
    { "zbirenbaum/copilot.lua" }, -- or github/copilot.vim
    { "nvim-lua/plenary.nvim" }, -- for curl, log wrapper
  },
  build = "make tiktoken", -- Only on MacOS or Linux
  opts = {
    debug = true, -- Enable debugging
    -- See Configuration section for rest
  },
  keys = {
    { "<leader>gc", "<cmd>CopilotChatOpen<cr>", desc = "Open Copilot Chat" },
  },
  -- See Commands section for default commands if you want to lazy load on them
}
