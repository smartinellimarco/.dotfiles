local M = { 'lewis6991/gitsigns.nvim' }

M.opts = {
  current_line_blame = true,
  current_line_blame_opts = {
    delay = 1000,
    ignore_whitespace = false,
    virt_text_priority = 5000, -- LSP diagnostics priority is 4096 (0x1000)
  },
  current_line_blame_formatter = '◦ <author>, <author_time:%Y-%m-%d> - <summary>',
  current_line_blame_formatter_nc = '◦ Not committed yet',
  yadm = {
    enable = true
  }
}

function M.config(_, opts)
  require('gitsigns').setup(opts)
end

return M

-- vim: ts=2 sts=2 sw=2 et
