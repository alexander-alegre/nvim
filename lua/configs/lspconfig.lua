-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

local lspconfig = require "lspconfig"

-- EXAMPLE
local servers = { "html", "cssls", "gopls", "htmx", "ts_ls", "tailwindcss", "emmet_ls", "templ" }
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }

-- configure html for templ
lspconfig.html.setup({
  on_attach = on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "html", "templ" },
})

-- configure htmx for templ
lspconfig.htmx.setup({
  on_attach = on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "html", "templ" },
})

-- configure css server
lspconfig["cssls"].setup({
  capabilities = nvlsp.capabilities,
  on_attach = on_attach,
})

-- configure tailwindcss server
lspconfig.tailwindcss.setup({
  on_attach = on_attach,
  capabilities = nvlsp.capabilities,
  filetypes = { "templ", "astro", "javascript", "typescript", "react" },
  settings = {
    tailwindCSS = {
      includeLanguages = {
        templ = "html",
      },
    },
  },
})

-- configure emmet language server
lspconfig["emmet_ls"].setup({
  capabilities = nvlsp.capabilities,
  on_attach = on_attach,
  filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "templ" },
})
