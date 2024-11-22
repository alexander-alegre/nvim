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
      -- Optional: Customize Copilot behavior here
      vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) -- Map <C-l> to accept suggestions
    end,
  },
}
