local M = { 'kevinhwang91/nvim-ufo' }

M.dependencies = 'kevinhwang91/promise-async'

function M.config(_, opts)
  -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
  vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
  vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)

  require('ufo').setup({
    provider_selector = function(bufnr, filetype, buftype)
      return { 'treesitter', 'indent' }
    end
  })
end

return M

-- vim: ts=2 sts=2 sw=2 et
