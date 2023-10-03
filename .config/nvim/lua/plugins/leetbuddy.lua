local M = { 'Dhanus3133/LeetBuddy.nvim' }

M.opts = {
  language = 'cpp'
}

function M.config(_, opts)
  require('leetbuddy').setup(opts)

  vim.keymap.set('n', '<leader>lq', '<cmd>LBQuestions<cr>', { desc = 'List Questions' })
  vim.keymap.set('n', '<leader>ll', '<cmd>LBQuestion<cr>', { desc = 'View Question' })
  vim.keymap.set('n', '<leader>lr', '<cmd>LBReset<cr>', { desc = 'Reset Code' })
  vim.keymap.set('n', '<leader>lt', '<cmd>LBTest<cr>', { desc = 'Run Code' })
  vim.keymap.set('n', '<leader>ls', '<cmd>LBSubmit<cr>', { desc = 'Submit Code' })
end

return M

-- vim: ts=2 sts=2 sw=2 et
