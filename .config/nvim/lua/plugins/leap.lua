local M = { 'ggandor/leap.nvim' }

function M.config()
  require('leap').create_default_mappings()
end

return M

-- vim: ts=2 sts=2 sw=2 et
