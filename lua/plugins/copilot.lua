return {
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure nvim-cmp is installed
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
      -- accept suggestion
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) -- Map <C-l> to accept suggestions
      -- next suggestion
      vim.api.nvim_set_keymap("i", "<C-j>", "copilot#Next()", { silent = true, expr = true })
      -- previous suggestion
      vim.api.nvim_set_keymap("i", "<C-k>", "copilot#Previous()", { silent = true, expr = true })
    end,
  },
}
