local M = {}

function M.setup()
  -- Diagnostics disappear if exiting insert mode with <C-c>
  vim.keymap.set('i', '<C-c>', '<Esc>')
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
