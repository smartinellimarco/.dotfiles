local M = { 'kevinhwang91/nvim-ufo' }

M.dependencies = 'kevinhwang91/promise-async'
M.opts = {
  provider_selector = function()
    return { 'treesitter', 'indent' }
  end,
}

function M.config(_, opts)
  -- Required by the plugin
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  require('ufo').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
