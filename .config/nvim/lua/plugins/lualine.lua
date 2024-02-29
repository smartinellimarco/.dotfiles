local M = { 'nvim-lualine/lualine.nvim' }

M.dependencies = {
  'AndreM222/copilot-lualine',
  { 'linrongbin16/lsp-progress.nvim', opts = {} },
}
M.opts = {
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { 'branch', 'diagnostics' },
    lualine_c = {
      { 'filename', path = 1 },
      function()
        return require('lsp-progress').progress()
      end,
    },
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
      { 'copilot' },
      { 'encoding' },
    },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
  extensions = {
    'oil',
    'quickfix',
    {
      sections = {
        lualine_a = {
          function()
            return 'Plugins'
          end,
        },
      },
      filetypes = { 'lazy' },
    },
    {
      sections = {
        lualine_a = {
          function()
            return 'LSPs'
          end,
        },
      },
      filetypes = { 'mason' },
    },
    {
      sections = {
        lualine_a = {
          function()
            return 'Telescope'
          end,
        },
      },
      filetypes = { 'TelescopePrompt' },
    },
  },
}

function M.config(_, opts)
  require('lualine').setup(opts)

  -- Refresh lualine on LSPs status changes
  vim.api.nvim_create_autocmd('User', {
    pattern = 'LspProgressStatusUpdated',
    callback = require('lualine').refresh,
  })

  -- Macro recording message
  vim.api.nvim_create_autocmd('RecordingEnter', {
    callback = function()
      require('lualine').refresh({
        place = { 'statusline' },
      })
    end,
  })

  vim.api.nvim_create_autocmd('RecordingLeave', {
    callback = function()
      -- The register does not clean up immediately after
      -- recording stops, so we have to wait a little bit (50ms)
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
end

return M

-- vim: ts=2 sts=2 sw=2 et
