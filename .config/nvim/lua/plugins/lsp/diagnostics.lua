local M = {}

function M.setup()
  vim.diagnostic.config({
    signs = false,
    virtual_text = {
      prefix = '◦',
      spacing = 0,
    },
    float = {
      border = 'rounded'
    }
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
