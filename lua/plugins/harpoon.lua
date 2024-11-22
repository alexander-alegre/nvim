return {
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
}
