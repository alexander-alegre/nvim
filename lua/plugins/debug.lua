return {
  -- Mason integration for managing DAP installations
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

  -- Core DAP functionality
  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    keys = {
      { "<leader>dD", "", desc = "+debug", mode = { "n", "v" } },
    },
  },

  -- Python-specific DAP configuration
  {
    "mfussenegger/nvim-dap-python",
    ft = "python",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local debugpy_path = vim.fn.stdpath "data" .. "/mason/packages/debugpy/venv/bin/python"
      require("dap-python").setup(debugpy_path)
    end,
  },

  -- Virtual text for DAP
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

  -- DAP UI for enhanced debugging interface
  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    keys = {
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
      {
        "<leader>de",
        function()
          require("dapui").eval()
        end,
        desc = "Evaluate Expression",
        mode = { "n", "v" },
      },
    },
    config = function(_, opts)
      local dap = require "dap"
      local dapui = require "dapui"

      -- Setup DAP UI with provided options
      dapui.setup(opts)

      -- Auto-open and close DAP UI on debug events
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- Go-specific DAP configuration
      require("dap-go").setup {
        dap_configurations = {
          {
            type = "go",
            name = "Attach Remote",
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

      -- DAP adapters and configurations

      -- Go (Delve)
      dap.adapters.delve = {
        type = "server",
        port = "${port}",
        executable = {
          command = "dlv",
          args = { "dap", "-l", "127.0.0.1:${port}" },
        },
      }
      dap.configurations.go = {
        {
          type = "delve",
          name = "Debug",
          request = "launch",
          program = "${file}",
        },
        {
          type = "delve",
          name = "Debug Test",
          request = "launch",
          mode = "test",
          program = "${file}",
        },
      }

      -- JavaScript/TypeScript (js-debug-adapter)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = 9229,
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath "data" .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
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
          name = "Launch File",
          program = "${file}",
          pythonPath = function()
            return os.getenv "VIRTUAL_ENV" and os.getenv "VIRTUAL_ENV" .. "/bin/python" or "python"
          end,
        },
      }
    end,
  },
}
