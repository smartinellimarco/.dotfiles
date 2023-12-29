local M = { 'eandrju/cellular-automaton.nvim' }

function M.config(_, _)
  local automaton = require('cellular-automaton')
  vim.keymap.set(
    'n',
    '<leader>smh',
    function()
      local animations = { 'make_it_rain', 'game_of_life' }
      _, _ = pcall(automaton.start_animation, animations[math.random(#animations)])
    end
  )
end

return M

-- vim: ts=2 sts=2 sw=2 et
