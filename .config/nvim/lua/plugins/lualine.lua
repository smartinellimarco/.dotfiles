local M = { 'nvim-lualine/lualine.nvim' }

M.dependencies = { 'AndreM222/copilot-lualine' }
M.opts = {
  options = {
    globalstatus = true,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = { { 'filename', path = 1 } },
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
      {
        'copilot',
        symbols = {
          spinners = { '⣾', '⣽', '⣻', '⢿', '⡿', '⣟', '⣯', '⣷' },
        },
      },
      {
        'lsp-progress',
        fmt = function()
          -- TODO: add spinner
          local clients = vim.lsp.get_active_clients()
          if next(clients) ~= nil then
            return ''
          else
            return ''
          end
        end,
      },
      'encoding',
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
