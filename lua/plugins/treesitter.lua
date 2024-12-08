return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      local configs = require "nvim-treesitter.configs"

      configs.setup {
        ensure_installed = {
          "c",
          "cpp",
          "lua",
          "vim",
          "vimdoc",
          "printf",
          "gitignore",
          "sql",
          "html",
          "css",
          "scss",
          "javascript",
          "typescript",
          "tsx",
          "json",
          "xml",
          "go",
          "python",
          "java",
          "bash",
          "toml",
          "yaml",
          "templ",
          "dockerfile",
          "editorconfig",
        },
        sync_install = false,
        highlight = { enable = true },
        indent = { enable = true },
      }
    end,
  },
}
