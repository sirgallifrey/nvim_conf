-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()

-- EXAMPLE
local nvlsp = require "nvchad.configs.lspconfig"

local servers = {
  html = {},
  cssls = {},
  ts_ls = {},
  elixirls = {
    cmd = { "elixir-ls" },
  },
  tailwindcss = {
    init_options = {
      userLanguages = {
        elixir = "html-eex",
        eelixir = "html-eex",
        heex = "html-eex",
      },
    },
  },
}

for name, opts in pairs(servers) do
  opts.on_init = nvlsp.on_init
  opts.on_attach = nvlsp.on_attach
  opts.capabilities = nvlsp.capabilities

  vim.lsp.config[name] = opts
  vim.lsp.enable(name)
end
