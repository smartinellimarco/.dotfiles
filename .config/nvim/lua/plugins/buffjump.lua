local M = { 'kwkarlwang/bufjump.nvim' }

M.opts = {}

function M.config(_, opts)
  require('bufjump').setup(opts)
  -- Clear jumplist when vim starts
  vim.api.nvim_command("autocmd VimEnter * exe 'clearjumps'")
end

return M

-- vim: ts=2 sts=2 sw=2 et
