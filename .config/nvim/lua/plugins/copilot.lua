local M = { 'zbirenbaum/copilot.lua' }

-- Node version must be > 18.x
M.cmd = 'Copilot'
M.event = 'InsertEnter'
M.opts = {
  panel = {
    enabled = false,
  },
  suggestion = {
    auto_trigger = true,
    debounce = 0,
    keymap = {
      accept = false,
      accept_word = false,
      accept_line = false,
      next = false,
      prev = false,
      dismiss = false,
    },
  },
}

function M.config(_, opts)
  require('copilot').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
