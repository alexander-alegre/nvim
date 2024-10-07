local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "eslint" },
    html = { "eslint" },
    ts = { "eslint" },
    js = { "eslint" },
  },

  format_on_save = {
    -- These options will be passed to conform.format()
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
