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
      },
    },
  },
  { "wakatime/vim-wakatime", lazy = false },
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
  -- harpoon
  {
    "abeldekat/harpoonline",
    lazy = true,
    config = function()
      -- the setup
    end,
  },
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    event = "VeryLazy",
    config = function()
      local harpoon = require "harpoon"
      harpoon:setup()
      --
      vim.keymap.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Add file to harpoon" })
      vim.keymap.set("n", "<leader>H", function()
        harpoon.ui:toggle_quick_menu(harpoon:list())
      end, { desc = "Toggle harpoon menu" })
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
  -- -- nvim v0.8.0
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
  -- debugger start
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "mfussenegger/nvim-dap",
      "leoluz/nvim-dap-go",
      "mfussenegger/nvim-dap-python",
    },
    config = function()
      require("mason-nvim-dap").setup {
        automatic_installation = true,
        ensure_installed = { "delve", "js-debug-adapter", "debugpy" },
      }
    end,
  },
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
      { "<leader>dD", "", desc = "+debug", mode = { "n", "v" } },
    },
  },
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      local path = "~/.local/share/nvim/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(path)
    end,
  },
  {
    "theHamsta/nvim-dap-virtual-text",
    opts = {
      enabled = true,
      commented = true,
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
    },
  },
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Dap UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Eval",
        mode = { "n", "v" },
      },
    },
    opts = {
      automatic_installation = true,
      ensure_installed = { "delve", "js-debug-adapter", "debugpy" },
    },
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"
      dapui.setup(opts)

      -- Auto-open DAP UI on debug events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Install golang specific config
      require("dap-go").setup {
        dap_configurations = {
          {
            type = "go",
            name = "Attach remote",
            mode = "remote",
            request = "attach",
          },
        },
        delve = {
          path = "dlv",
          initialize_timeout_sec = 20,
          port = "${port}",
          args = {},
          build_flags = {},
          detached = vim.fn.has "win32" == 0,
          cwd = nil,
        },
        tests = {
          verbose = true,
        },
      }

      -- Debugger adapters and configurations
      -- Go (delve)
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }
      dap.configurations.go = {
        { type = "delve", name = "Debug", request = "launch", program = "${file}" },
        { type = "delve", name = "Debug Test", request = "launch", mode = "test", program = "${file}" },
      }

      -- JavaScript/TypeScript (js-debug-adapter)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = 9229,
        executable = {
          command = "node",
          args = {
            os.getenv "HOME" .. "/.local/share/nvim/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            9229,
          },
        },
      }
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch Program",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }
      dap.configurations.typescript = dap.configurations.javascript

      -- Python (debugpy)
      dap.adapters.python = {
        type = "executable",
        command = "python",
        args = { "-m", "debugpy.adapter" },
      }
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          pythonPath = function()
            return os.getenv "VIRTUAL_ENV" and os.getenv "VIRTUAL_ENV" .. "/bin/python" or "python"
          end,
        },
      }
    end,
  },
  -- debugger end
  {
    "kristijanhusak/vim-dadbod-ui",
    dependencies = {
      { "tpope/vim-dadbod", lazy = true },
      { "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true }, -- Optional
    },
    cmd = {
      "DBUI",
      "DBUIToggle",
      "DBUIAddConnection",
      "DBUIFindBuffer",
    },
    init = function()
      -- Your DBUI configuration
      vim.g.db_ui_use_nerd_fonts = 1
    end,
  },
  -- copilot
  {
    "github/copilot.vim",
    event = "VeryLazy",
    config = function()
      -- Optional: Customize Copilot behavior here
      vim.g.copilot_no_tab_map = true -- Disable default Tab mapping
      vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true }) -- Map <C-l> to accept suggestions
    end,
  },
  {
    "zbirenbaum/copilot-cmp",
    dependencies = { "hrsh7th/nvim-cmp" }, -- Ensure nvim-cmp is installed
    config = function()
      require("copilot_cmp").setup()
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require "cmp"
      cmp.setup {
        sources = {
          { name = "copilot" }, -- Add Copilot as a completion source
          { name = "nvim_lsp" },
          { name = "buffer" },
          { name = "path" },
        },
      }
    end,
  },
  {
    "rmagatti/auto-session",
    lazy = false,
    opts = {
      suppressed_dirs = { "~/", "~/code" },
      -- log_level = 'debug',
    },
  },
  -- PHP (Laravel)
  {
    "adalessa/laravel.nvim",
    dependencies = {
      "tpope/vim-dotenv",
      "nvim-telescope/telescope.nvim",
      "MunifTanjim/nui.nvim",
      "kevinhwang91/promise-async",
    },
    cmd = { "Laravel" },
    keys = {
      { "<leader>la", ":Laravel artisan<cr>" },
      { "<leader>lr", ":Laravel routes<cr>" },
      { "<leader>lm", ":Laravel related<cr>" },
    },
    event = { "VeryLazy" },
    opts = {},
    config = true,
  },
}
