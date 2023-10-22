local M = { 'ggandor/leap.nvim' }

function M.config(_, _)
  require("leap").add_default_mappings()
end

return M

-- vim: ts=2 sts=2 sw=2 et
