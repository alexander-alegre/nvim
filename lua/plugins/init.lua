return {
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "eslint-lsp",
        "prettier",
        "tailwindcss-language-server",
        "typescript-language-server",
        "javascript-language-server",
        "prismals",
        "mypy",
        "ruff",
        "black",
        "pyright",
        "delve",
        "js-debug-adapter",
        "debugpy",
        "bash-language-server",
        "shellcheck",
        "shfmt",
        "clangd",
        "sourcekit-lsp",
      },
    },
  },
  {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    opts = require "configs.conform",
  },
  {
    "nvimtools/none-ls.nvim",
    event = "VeryLazy",
    opts = function()
      return require "plugins.null-ls"
    end,
  },
  {
    "joerdav/templ.vim",
    event = "VeryLazy",
    config = function()
      -- todo
    end,
  },
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    config = function()
      -- todo
    end,
  },
  {
    "atiladefreitas/dooing",
    event = "VeryLazy",
    config = function()
      require("dooing").setup {
        -- your custom config here (optional)
      }
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    event = "BufReadPre",
    config = function()
      require("nvim-ts-autotag").setup {
        opts = {
          enable_close = true, -- Auto close tags
          enable_rename = true, -- Auto rename pairs of tags
          enable_close_on_slash = true, -- Auto close on trailing </
        },
        aliases = {
          ["templ"] = "html",
          ["tmpl"] = "html",
        },
      }
    end,
  },
  {
    "stevearc/dressing.nvim",
    opts = {},
    event = "VeryLazy",
    config = function()
      require("dressing").setup {
        -- your custom config here (optional)
      }
    end,
  },
}
