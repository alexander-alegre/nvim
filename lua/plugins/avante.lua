return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = true,
    version = false, -- set this if you want to always pull the latest change
    opts = {
      -- Specify Copilot as the AI provider
      provider = "copilot",
      -- You can add additional options here as needed
      copilot = {
        -- Optional: Configure Copilot settings
        suggestion = {
          enabled = true,
          auto_trigger = true,
        },
        panel = {
          enabled = true,
          auto_refresh = true,
        },
        -- Add more Copilot-specific configurations if necessary
      },
    },
    -- If you want to build from source then do `make BUILD_FROM_SOURCE=true`
    build = "make",
    -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
    dependencies = {
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "hrsh7th/nvim-cmp", -- Autocompletion for Avante commands and mentions
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "zbirenbaum/copilot.lua", -- For Copilot integration
      {
        -- Support for image pasting
        "HakonHarnes/img-clip.nvim",
        event = "VeryLazy",
        opts = {
          -- Recommended settings
          default = {
            embed_image_as_base64 = false,
            prompt_for_file_name = false,
            drag_and_drop = {
              insert_mode = true,
            },
            -- Required for Windows users
            use_absolute_path = true,
          },
        },
      },
      {
        -- Render Markdown files properly
        "MeanderingProgrammer/render-markdown.nvim",
        opts = {
          file_types = { "markdown", "Avante" },
        },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
