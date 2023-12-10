local M = { 'nvim-lualine/lualine.nvim' }

M.opts = {
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
    disabled_filetypes = { 'TelescopePrompt', 'lazy', 'mason' },
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = { 'filename' },
    lualine_x = { 'encoding' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' }
  }
}

function M.config(_, opts)
  require('lualine').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
