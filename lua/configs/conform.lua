local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "eslint" },
    html = { "eslint" },
    js = { "eslint" },
    ts = { "eslint" },
    tsx = { "eslint" },
    jsx = { "eslint" },
    python = { "black" },
    sh = { "shfmt" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
