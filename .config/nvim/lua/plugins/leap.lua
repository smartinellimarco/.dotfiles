local M = { 'ggandor/leap.nvim' }

function M.config(_, _)
  vim.keymap.set({'n', 'v'}, 's', function ()
    local focusable_windows_on_tabpage = vim.tbl_filter(
      function (win) return vim.api.nvim_win_get_config(win).focusable end,
      vim.api.nvim_tabpage_list_wins(0)
    )
    require('leap').leap { target_windows = focusable_windows_on_tabpage }
  end)
end

return M

-- vim: ts=2 sts=2 sw=2 et
