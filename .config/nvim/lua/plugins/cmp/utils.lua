local M = {}

local cmp = require('cmp')
local luasnip = require('luasnip')

function M.i_CTRL_N(_)
  return cmp.mapping(
    function(_)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_locally_jumpable() then
        luasnip.expand_or_jump()
      else
        cmp.complete()
      end
    end, { 'i', 's' })
end

function M.i_CTRL_P(_)
  return cmp.mapping(
    function(_)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        cmp.complete()
      end
    end, { 'i', 's' })
end

return M

-- vim: ts=2 sts=2 sw=2 et
