-- TODO: https://github.com/nvim-lualine/lualine.nvim/pull/1227
local M = { 'nvim-lualine/lualine.nvim' }

M.dependencies = 'yavorski/lualine-macro-recording.nvim'
M.opts = {
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'filename',
        path = 1,
        fmt = function(filename)
          local filetype = vim.bo.filetype
          if filetype == 'oil' then
            return require('oil').get_current_dir()
          elseif filetype == 'TelescopePrompt' then
            return 'telescope'
          elseif filetype == 'lazy' then
            return 'lazy'
          elseif filetype == 'mason' then
            return 'mason'
          end
          return filename
        end,
      },
    },
    lualine_c = { 'branch', 'diagnostics' },
    lualine_x = {
      'macro_recording',
      'encoding',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

function M.config(_, opts)
  require('lualine').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
