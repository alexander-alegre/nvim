return {
  {
    "nvim-neotest/neotest",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-golang",
          require "neotest-python",
        },
      }
    end,
  },
  {
    "andythigpen/nvim-coverage",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Changed from 'requires' to 'dependencies'
    rocks = { "lua-xmlreader" },
    config = function()
      require("coverage").setup {
        commands = true, -- create commands
        highlights = {
          covered = { fg = "#C3E88D" },
          uncovered = { fg = "#F07178" },
        },
        signs = {
          covered = { hl = "CoverageCovered", text = "▎" },
          uncovered = { hl = "CoverageUncovered", text = "▎" },
        },
        summary = {
          min_coverage = 80.0,
        },
        lang = {
          -- customize language-specific settings
        },
      }
    end,
  },
}
