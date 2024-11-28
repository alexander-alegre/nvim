local null_ls = require "null-ls"
local b = null_ls.builtins
local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

-- Return a valid table
return {
  "jose-elias-alvarez/null-ls.nvim",
  config = function()
    null_ls.setup {
      sources = {
        -- Add Prettier as a formatter
        b.formatting.prettierd.with {
          filetypes = { "javascript", "typescript", "html", "css", "json", "yaml", "markdown", "jsx", "tsx" },
        },
        -- Python formatter
        b.formatting.black,
        -- Python diagnostics
        b.diagnostics.mypy,
        b.diagnostics.ruff,
        -- shell
        b.diagnostics.shellcheck,
        b.formatting.shfmt,
      },
      on_attach = function(client, bufnr)
        if client.supports_method "textDocument/formatting" then
          vim.api.nvim_clear_autocmds {
            group = augroup,
            buffer = bufnr,
          }
          vim.api.nvim_create_autocmd("BufWritePre", {
            group = augroup,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format { bufnr = bufnr, async = true }
            end,
          })
        end
      end,
    }
  end,
}
