local M = { 'ggandor/leap.nvim' }

-- TODO: issue: https://github.com/ggandor/leap.nvim/issues/224
function M.config()
  require('leap').create_default_mappings()
end

return M

-- vim: ts=2 sts=2 sw=2 et
