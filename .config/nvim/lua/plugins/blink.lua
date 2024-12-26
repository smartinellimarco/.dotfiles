local M = { 'saghen/blink.cmp' }

M.version = '*'
M.event = 'InsertEnter'
M.dependencies = 'rafamadriz/friendly-snippets'
M.opts = {
  completion = {
    menu = {
      border = 'rounded',
      draw = {
        -- TODO: enable when release comes out
        -- align_to = 'cursor',
        columns = {
          { 'label' },
          { 'kind_icon', 'kind', gap = 1 },
          { 'label_description' },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 500,
      window = { border = 'rounded' },
    },
  },
  keymap = {
    preset = 'none',
    ['<C-f>'] = { 'accept' },
    -- Do not fallback in order to disable i_CTRL-N and i_CTRL-P
    -- TODO: customize snippet forward and backward
    ['<C-p>'] = { 'snippet_forward', 'select_prev' },
    ['<C-n>'] = { 'snippet_backward', 'select_next' },
    ['<C-u>'] = { 'scroll_documentation_up' },
    ['<C-d>'] = { 'scroll_documentation_down' },
    ['<C-e>'] = { 'cancel' },
  },
}

function M.config(_, opts)
  require('blink.cmp').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
