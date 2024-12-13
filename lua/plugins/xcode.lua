return {
  {
    "wojciech-kulik/xcodebuild.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-tree.lua", -- (optional) to manage project files
      "nvim-treesitter/nvim-treesitter", -- (optional) for Quick tests support (required Swift parser)
    },
    -- Define key mappings as a list
    keys = {
      { "<leader>Xb", "<cmd>XcodeBuild build<CR>", desc = "XcodeBuild: Build" },
      { "<leader>Xr", "<cmd>XcodeBuild run<CR>", desc = "XcodeBuild: Run" },
      { "<leader>Xt", "<cmd>XcodeBuild test<CR>", desc = "XcodeBuild: Test" },
      { "<leader>Xc", "<cmd>XcodeBuild clean<CR>", desc = "XcodeBuild: Clean" },
      { "<leader>Xs", "<cmd>XcodeBuild switch<CR>", desc = "XcodeBuild: Switch Scheme" },
      { "<leader>Xo", "<cmd>XcodeBuild open<CR>", desc = "XcodeBuild: Open Project" },
      { "<leader>Xl", "<cmd>XcodeBuild list<CR>", desc = "XcodeBuild: List Targets" },
      { "<leader>Xg", "<cmd>XcodeBuild log<CR>", desc = "XcodeBuild: Show Logs" },
      { "<leader>Xx", "<cmd>XcodeBuild toggle<CR>", desc = "XcodeBuild: Toggle UI" },
    },
    config = function()
      require("xcodebuild").setup {
        -- Add any specific configuration options here
      }
    end,
  },
}
