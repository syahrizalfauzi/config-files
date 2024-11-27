return {
  "hrsh7th/nvim-cmp",
  lazy = false,
  opts = {
    mapping = {
      -- disable  tab
      ["<Tab>"] = function(callback)
        callback()
      end,

      ["<S-Tab>"] = function(callback)
        callback()
      end,
    }
  }
}
