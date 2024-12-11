require "nvchad.options"

-- add yours here!
local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!

-- folding
o.foldmethod = "expr" -- Set fold method to "expr"
o.foldenable = true -- Enable folding by default
o.foldlevel = 99 -- Open all folds by default
o.foldexpr = "nvim_treesitter#foldexpr()"

vim.filetype.add {
  extension = {
    env = "sh", -- Treat .env files as shell scripts for syntax highlighting
  },
}
