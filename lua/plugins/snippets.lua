return {
  {
    "L3MON4D3/LuaSnip",
    config = function()
      -- Setup LuaSnip
      require("luasnip").setup {}

      -- Load default snippets from friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load custom snippets from your specified path
      require("luasnip.loaders.from_vscode").lazy_load {
        paths = vim.fn.stdpath "config" .. "/lua/snippets",
      }
    end,
  },
  -- Friendly Snippets
  {
    "rafamadriz/friendly-snippets",
    -- Ensure LuaSnip is loaded before friendly-snippets
    dependencies = { "L3MON4D3/LuaSnip" },
  },
}
