local null_ls = require "null-ls"
local b = null_ls.builtins

-- Return a valid table
return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    null_ls.setup {
      ensure_installed = { "javascript", "typescript", "tsx", "jsx" },
      sources = {
        -- Add Prettier as a formatter
        b.formatting.prettierd.with {
          filetypes = { "javascript", "typescript", "html", "css", "json", "yaml", "markdown", "jsx", "tsx" },
        },
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr }
            end,
          })
        end
      end,
    }
  end,
}
