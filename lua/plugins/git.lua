return {
  -- nvim v0.8.0
  {
    "kdheepak/lazygit.nvim",
    event = "VeryLazy",
    cmd = {
      "LazyGit",
      "LazyGitConfig",
      "LazyGitCurrentFile",
      "LazyGitFilter",
      "LazyGitFilterCurrentFile",
    },
    -- optional for floating window border decoration
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    -- setting the keybinding for LazyGit with 'keys' is recommended in
    -- order to load the plugin when the command is run for the first time
    keys = {
      { "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" },
    },
  },
  -- blamer
  {
    "APZelos/blamer.nvim",
    event = "VeryLazy",
    config = function()
      vim.g.blamer_enabled = 1 -- Enable Blamer
      vim.g.blamer_show_in_insert_modes = 0 -- Don't show in insert mode
      vim.g.blamer_delay = 500 -- Delay (ms) before showing blame
      vim.g.blamer_relative_time = 1 -- Show relative time (e.g., "2 days ago")
      vim.g.blamer_date_format = "%d-%m-%Y" -- Custom date format if relative_time is 0
      vim.g.blamer_prefix = "  " -- Custom prefix for blame text
      vim.g.blamer_template = "<author> • <summary> • <date>" -- Template for blame text
      vim.g.blamer_highlight = "Comment" -- Highlight group for blame text
    end,
  },
}
