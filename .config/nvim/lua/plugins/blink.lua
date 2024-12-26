-- TODO: only keep one col for / ? and :
-- TODO: customize snippet movement like with luasnip (-- Do not fallback in order to disable i_CTRL-N and i_CTRL-P)
-- TODO: lualine blinking
-- TODO: enable align_to when release comes out

local M = { 'saghen/blink.cmp' }

M.version = '*'
M.event = 'InsertEnter'
M.dependencies = 'rafamadriz/friendly-snippets'
M.opts = {
  completion = {
    menu = {
      border = 'rounded',
      draw = {
        -- align_to = 'cursor',
        columns = { -- Imitate 'nvim-cmp'
          { 'label' },
          { 'kind_icon', 'kind', gap = 1 },
          { 'label_description' },
        },
      },
    },
    documentation = {
      auto_show = true,
      window = { border = 'rounded' },
    },
  },
  keymap = {
    preset = 'none',

    ['<C-f>'] = { 'accept' },
    ['<C-p>'] = { 'select_prev' },
    ['<C-n>'] = { 'select_next' },
    ['<C-u>'] = { 'scroll_documentation_up' },
    ['<C-d>'] = { 'scroll_documentation_down' },
    ['<C-e>'] = { 'cancel' },

    cmdline = {
      preset = 'none',

      ['<C-f>'] = { 'accept' },
      ['<C-p>'] = { 'select_prev' },
      ['<C-n>'] = { 'select_next' },
      ['<Tab>'] = { function() end }, -- TODO: create issue for no-op
    },
  },
}

function M.config(_, opts)
  require('blink.cmp').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et