local M = { 'williamboman/mason.nvim' }

M.lazy = false -- Lazy loading mason may produce errors
M.opts = {
  ui = {
    border = 'rounded',
  },
}
function M.config(_, opts)
  require('mason').setup(opts)

  local registry = require('mason-registry')

  -- These are package names sourced from the Mason registry,
  -- and may not necessarily match the server names used in lspconfig
  local ensure_installed = {
    'yaml-language-server',
    'terraform-ls',
    'stylua',
    'pyright',
    'marksman',
    'lua-language-server',
    'json-lsp',
    'isort',
    'gopls',
    'docker-compose-language-service',
    'clangd',
    'black',
  }

  -- Ensure packages are installed and up to date
  registry.refresh(function()
    for _, name in pairs(ensure_installed) do
      local package = registry.get_package(name)
      if not registry.is_installed(name) then
        package:install()
      else
        package:check_new_version(function(success, result_or_err)
          if success then
            package:install({ version = result_or_err.latest_version })
          end
        end)
      end
    end
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
