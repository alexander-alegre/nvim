require "nvchad.options"

-- add yours here!
local o = vim.o
o.cursorlineopt = "both" -- to enable cursorline!

vim.filetype.add {
  extension = {
    env = "sh", -- Treat .env files as shell scripts for syntax highlighting
  },
}
