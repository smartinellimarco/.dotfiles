local M = { 'ggandor/leap.nvim' }

local function focusable_windows_on_tabpage()
  -- Create a filtered list of focusable windows on the current tabpage
  local windows = vim.tbl_filter(

  -- Function that checks if window is focusable
    function(win)
      return vim.api.nvim_win_get_config(win).focusable
    end,

    -- Retrieve a list of all windows on the current tabpage
    vim.api.nvim_tabpage_list_wins(0)
  )
  return windows
end

M.opts = {
  special_keys = {
    next_group = '<space>',
    prev_group = '<tab>',
  }
}

function M.config(_, opts)
  vim.keymap.set({ 'n', 'v' }, 's',
    function() require('leap').leap({ opts, target_windows = focusable_windows_on_tabpage() }) end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
