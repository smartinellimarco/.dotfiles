local M = { 'nvim-lualine/lualine.nvim' }

M.opts = {
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = {
      statusline = { 'TelescopePrompt', 'lazy', 'mason' }
    }
  }
}

function M.config(_, opts)
  require('lualine').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
