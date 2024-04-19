-- FIXME: deprecate when 0.10 arrives
local M = { 'kevinhwang91/nvim-ufo' }

M.dependencies = 'kevinhwang91/promise-async'
M.opts = {
  provider_selector = function()
    return { 'treesitter', 'indent' }
  end,
}

function M.config(_, opts)
  local ufo = require('ufo')

  ufo.setup(opts)

  -- Required by the plugin
  vim.keymap.set('n', 'zR', ufo.openAllFolds)
  vim.keymap.set('n', 'zM', ufo.closeAllFolds)
end

return M

-- vim: ts=2 sts=2 sw=2 et
