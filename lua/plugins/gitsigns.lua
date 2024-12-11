return {
  {
    "lewis6991/gitsigns.nvim",
    event = "VeryLazy",
    requires = { "nvim-lua/plenary.nvim" },
    config = function()
      require("gitsigns").setup {
        -- Existing configurations
        numhl = false,
        linehl = false,
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default

        -- New configurations for keybindings
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          -- Define a helper function to set keymaps
          local function map(mode, lhs, rhs, desc)
            local opts = { noremap = true, silent = true, buffer = bufnr, desc = desc }
            vim.keymap.set(mode, lhs, rhs, opts)
          end

          -- Navigation between hunks
          map("n", "]c", function()
            if vim.wo.diff then
              return "]c"
            end
            vim.schedule(function()
              gs.next_hunk()
            end)
            return "<Ignore>"
          end, "Go to next Git hunk")

          map("n", "[c", function()
            if vim.wo.diff then
              return "[c"
            end
            vim.schedule(function()
              gs.prev_hunk()
            end)
            return "<Ignore>"
          end, "Go to previous Git hunk")

          -- Actions
          map("n", "<leader>gs", gs.stage_hunk, "Stage hunk")
          map("n", "<leader>gr", gs.reset_hunk, "Reset hunk")
          map("v", "<leader>gs", function()
            gs.stage_hunk { vim.fn.line ".", vim.fn.line "v" }
          end, "Stage selected hunk")
          map("n", "<leader>gS", gs.stage_buffer, "Stage buffer")
          map("n", "<leader>gu", gs.undo_stage_hunk, "Undo stage hunk")
          map("n", "<leader>gR", gs.reset_buffer, "Reset buffer")
          map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
          map("n", "<leader>gb", function()
            gs.blame_line { full = true }
          end, "Blame line")
          map("n", "<leader>hd", gs.diffthis, "Diff this")
          map("n", "<leader>hD", function()
            gs.diffthis "~"
          end, "Diff this ~")
          map("n", "<leader>td", gs.toggle_deleted, "Toggle deleted")
        end,
      }
    end,
  },
}
