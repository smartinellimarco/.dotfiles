-- TODO: https://github.com/nvim-lualine/lualine.nvim/pull/1227
-- TODO: remove command mode refresh
local M = { 'nvim-lualine/lualine.nvim' }

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
      {
        'macro-recording',
        fmt = function()
          local register = vim.fn.reg_recording()
          if register == '' then
            return ''
          else
            return 'Recording @' .. register
          end
        end,
      },
      'encoding',
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
}

function M.config(_, opts)
  -- Update lualine on recording events
  vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function()
      require('lualine').refresh({
        place = { 'statusline' },
      })
    end,
  })

  -- The register does not clean up immediately after
  -- recording stops, so we have to wait a little bit (50ms)
  vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
      local timer = vim.loop.new_timer()
      timer:start(
        50,
        0,
        vim.schedule_wrap(function()
          require('lualine').refresh({
            place = { 'statusline' },
          })
        end)
      )
    end,
  })

  require('lualine').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
