local M = { 'ggandor/leap.nvim' }

-- Create a filtered list of focusable windows on the current tabpage
M.focusable_windows_on_tabpage = vim.tbl_filter(

  -- Function that checks if a window is focusable
  function(win)
    return vim.api.nvim_win_get_config(win).focusable
  end,

  -- Retrieve a list of all windows on the current tabpage
  vim.api.nvim_tabpage_list_wins(0)
)

M.opts = {
  special_keys = {
    next_group = '<space>',
    prev_group = '<tab>',
  },
  target_windows = M.focusable_windows_on_tabpage,
}

function M.config(_, opts)
  vim.keymap.set({ 'n', 'v' }, 's', function() require('leap').leap(opts) end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
