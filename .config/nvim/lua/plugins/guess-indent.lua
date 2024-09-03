-- TODO: https://github.com/NMAC427/guess-indent.nvim/issues/21
local M = { 'NMAC427/guess-indent.nvim' }

M.opts = {
  override_editorconfig = false,
}

function M.config(_, opts)
  require('guess-indent').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
