local M = { 'Dhanus3133/LeetBuddy.nvim' }

M.keys = {
  { '<leader>lq', '<cmd>LBQuestions<cr>', desc = 'List Questions' },
  { '<leader>ll', '<cmd>LBQuestion<cr>',  desc = 'View Question' },
  { '<leader>lr', '<cmd>LBReset<cr>',     desc = 'Reset Code' },
  { '<leader>lt', '<cmd>LBTest<cr>',      desc = 'Run Code' },
  { '<leader>ls', '<cmd>LBSubmit<cr>',    desc = 'Submit Code' },
}

function M.config(_, opts)
  require('leetbuddy').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
