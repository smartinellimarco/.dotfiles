local M = {}

function M.setup(client)
  client.server_capabilities.semanticTokensProvider = nil
end

return M

-- vim: ts=2 sts=2 sw=2 et
