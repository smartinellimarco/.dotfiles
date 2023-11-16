-- TODO: see: https://github.com/nvim-lualine/lualine.nvim/pull/1114#issuecomment-1815171929
local M = { 'nvim-lualine/lualine.nvim' }

M.opts = {
  options = {
    globalstatus = true
  },
  extensions = {
    {
      filetypes = { 'TelescopePrompt' },
      sections = {
        lualine_a = {
          function()
            return 'Telescope'
          end
        }
      }
    }
  }
}

function M.config(_, opts)
  require('lualine').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
