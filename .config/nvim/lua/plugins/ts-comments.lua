local M = { 'folke/ts-comments.nvim' }

M.event = { 'VeryLazy' }
M.opts = {
  lang = {
    lua = "-- %s"
  }
}

function M.config(_, opts)
  require('ts-comments').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
