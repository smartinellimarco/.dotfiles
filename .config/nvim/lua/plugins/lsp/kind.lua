local M = {}

local _symbol_map = {
  Text = "󰉿",
  Method = "󰆧",
  Function = "󰊕",
  Constructor = "",
  Field = "󰜢",
  Variable = "󰀫",
  Class = "󰠱",
  Interface = "",
  Module = "",
  Property = "󰜢",
  Unit = "󰑭",
  Value = "󰎠",
  Enum = "",
  Keyword = "󰌋",
  Snippet = "",
  Color = "󰏘",
  File = "󰈙",
  Reference = "󰈇",
  Folder = "󰉋",
  EnumMember = "",
  Constant = "󰏿",
  Struct = "󰙅",
  Event = "",
  Operator = "󰆕",
  TypeParameter = "",
}

local function _format_kind(kind, symbol)
  return string.format('%s %s', symbol, kind)
end

local function _setup_symbols()
  local cmp_item_kind = require('vim.lsp.protocol').CompletionItemKind

  for index, kind in ipairs(cmp_item_kind) do
    cmp_item_kind[index] = _format_kind(kind, _symbol_map[kind])
  end
end

function M.setup()
  _setup_symbols()
end

return M

-- vim: ts=2 sts=2 sw=2 et
