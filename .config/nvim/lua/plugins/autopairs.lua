local M = { 'windwp/nvim-autopairs' }

M.event = { 'BufReadPre', 'BufNewFile' }
M.opts = {
  check_ts = true,
  enable_check_bracket_line = false,
}

function M.config(_, opts)
  require('nvim-autopairs').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
