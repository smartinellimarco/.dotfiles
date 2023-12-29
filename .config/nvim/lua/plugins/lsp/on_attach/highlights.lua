local M = {}

function M.setup(client)
  -- Hide all semantic highlights
  for _, group in ipairs(vim.fn.getcompletion("@lsp", "highlight")) do
    vim.api.nvim_set_hl(0, group, {})
  end
end

return M

-- vim: ts=2 sts=2 sw=2 et
