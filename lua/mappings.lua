require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map(
  "n",
  "<leader>fu",
  ':lua require("telescope.builtin").lsp_references()<CR>',
  { noremap = true, silent = true, desc = "Find usages" }
)

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")
