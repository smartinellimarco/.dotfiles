vim.loader.enable()

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.o.winborder = 'rounded'
vim.o.breakindent = true
vim.o.cursorline = true
vim.o.updatetime = 250
vim.o.timeoutlen = 300
vim.o.confirm = true
vim.o.hlsearch = false
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.undofile = true
vim.o.splitright = true
vim.o.splitbelow = true
vim.o.fillchars = 'eob: '
vim.o.signcolumn = 'yes:1'
vim.o.number = true
vim.o.showtabline = 0

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

-- See :h 'shortmess' for flag meanings
vim.opt.shortmess:append('WIsqAacS')

vim.diagnostic.config({
  signs = false,
  virtual_text = { prefix = '◦', spacing = 0 },
  update_in_insert = false, -- don't publish new diags while typing
})

-- Hide diagnostic visuals entirely while in insert mode.
vim.api.nvim_create_autocmd('InsertEnter', {
  callback = function()
    vim.diagnostic.hide()
  end,
})
vim.api.nvim_create_autocmd('InsertLeave', {
  callback = function()
    vim.diagnostic.show()
  end,
})

vim.api.nvim_create_autocmd('VimEnter', {
  callback = function()
    vim.cmd('clearjumps')
  end,
})

-- plugins (vim.pack)

local gh = function(repo)
  return 'https://github.com/' .. repo
end

vim.pack.add({
  -- Filetree
  {
    src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
    version = vim.version.range('3'),
  },
  'https://github.com/nvim-lua/plenary.nvim',
  'https://github.com/MunifTanjim/nui.nvim',
  gh('antosha417/nvim-lsp-file-operations'),

  -- Colorscheme
  gh('gbprod/nord.nvim'),

  -- UI
  gh('nvim-lualine/lualine.nvim'),
  gh('yavorski/lualine-macro-recording.nvim'),
  gh('lewis6991/gitsigns.nvim'),
  gh('purarue/gitsigns-yadm.nvim'),

  gh('lukas-reineke/indent-blankline.nvim'),

  -- Editing
  'https://codeberg.org/andyg/leap.nvim',
  gh('windwp/nvim-autopairs'),
  { src = gh('kylechui/nvim-surround'), version = vim.version.range('4') },
  gh('folke/ts-comments.nvim'),
  gh('NMAC427/guess-indent.nvim'),

  -- Picker
  gh('ibhagwan/fzf-lua'),

  -- Treesitter
  gh('romus204/tree-sitter-manager.nvim'),
  {
    src = gh('nvim-treesitter/nvim-treesitter-textobjects'),
    version = 'main',
  },

  -- Completion
  gh('rafamadriz/friendly-snippets'),
  { src = gh('saghen/blink.cmp'), version = vim.version.range('1') },

  -- Formatter
  gh('stevearc/conform.nvim'),

  -- LSP
  gh('neovim/nvim-lspconfig'),
  gh('folke/lazydev.nvim'),
  gh('RRethy/vim-illuminate'),
})

-- colorscheme

require('nord').setup({
  on_highlights = function(hl, c)
    -- Leap: colored letters, no backgrounds.
    hl.LeapMatch = { fg = c.frost.polar_water, bold = true, nocombine = true }
    hl.LeapLabel = { fg = c.aurora.yellow, bold = true }
    hl.LeapLabelPrimary = { fg = c.aurora.green, bold = true, nocombine = true }
    hl.LeapLabelSecondary =
      { fg = c.aurora.purple, bold = true, nocombine = true }
    hl.LeapLabelSelected =
      { fg = c.aurora.yellow, bold = true, nocombine = true }
    -- Diagnostic virtual text: drop the colored strip background.
    hl.DiagnosticVirtualTextError = { fg = c.aurora.red }
    hl.DiagnosticVirtualTextWarn = { fg = c.aurora.yellow }
    hl.DiagnosticVirtualTextInfo = { fg = c.frost.ice }
    hl.DiagnosticVirtualTextHint = { fg = c.frost.artic_water }
  end,
})
vim.cmd.colorscheme('nord')

-- plugin setup

require('nvim-autopairs').setup({
  check_ts = true,
  map_c_w = true,
  map_c_h = true,
})

require('ts-comments').setup()

require('guess-indent').setup()

require('ibl').setup({
  indent = { char = '┊' },
  scope = { enabled = false },
})

do
  local gs = require('gitsigns')
  gs.setup({
    _on_attach_pre = function(bufnr, callback)
      require('gitsigns-yadm').yadm_signs(callback, { bufnr = bufnr })
    end,
    current_line_blame_opts = {
      delay = 500,
      virt_text_priority = 5000, -- LSP diagnostics priority is 4096 (0x1000)
    },
    current_line_blame_formatter = '◦ <author>, <author_time:%Y-%m-%d> - <summary>',
    current_line_blame_formatter_nc = '◦ Not committed yet',
  })
  -- gs.nav_hunk is async, which breaks operator-pending motions
  -- (the callback returns before the cursor moves, so vim sees no motion).
  -- We resolve the target hunk synchronously from gs.get_hunks() and jump.
  local function jump_to(h)
    local n = vim.api.nvim_buf_line_count(0)
    local line = math.max(1, math.min(h.added.start, n))
    vim.api.nvim_win_set_cursor(0, { line, 0 })
  end

  local function nav(dir)
    return function()
      local hunks = gs.get_hunks(0) or {}
      if #hunks == 0 then
        return
      end
      local row = vim.api.nvim_win_get_cursor(0)[1]
      local target
      if dir == 'next' then
        for _, h in ipairs(hunks) do
          if h.added.start > row then
            target = h
            break
          end
        end
        target = target or hunks[1]
      else
        for i = #hunks, 1, -1 do
          if hunks[i].added.start < row then
            target = hunks[i]
            break
          end
        end
        target = target or hunks[#hunks]
      end
      jump_to(target)
    end
  end

  vim.keymap.set({ 'n', 'x', 'o' }, ']g', nav('next'))
  vim.keymap.set({ 'n', 'x', 'o' }, '[g', nav('prev'))

  -- ig: text object — containing hunk, else next, else wrap. Selects iff
  -- the hunk has buffer content (added.count > 0); pure-delete hunks just
  -- get a cursor jump, because select_hunk would emit a wonky range for
  -- them (e.g. `0G` when added.start is 0 for a top-of-file delete).
  vim.keymap.set({ 'o', 'x' }, 'ig', function()
    local hunks = gs.get_hunks(0) or {}
    if #hunks == 0 then
      return
    end
    local row = vim.api.nvim_win_get_cursor(0)[1]
    local function contains(h)
      return h.added.count > 0
        and row >= h.added.start
        and row <= h.added.start + h.added.count - 1
    end
    local target
    for _, h in ipairs(hunks) do
      if contains(h) then
        target = h
        break
      end
    end
    if not target then
      for _, h in ipairs(hunks) do
        if h.added.start > row then
          target = h
          break
        end
      end
      target = target or hunks[1]
    end
    jump_to(target)
    if target.added.count > 0 then
      gs.select_hunk()
    end
  end)
end

require('lualine').setup({
  options = {
    theme = 'nord',
    globalstatus = true,
    icons_enabled = false,
    component_separators = '',
    section_separators = '',
  },
  sections = {
    lualine_a = { 'mode' },
    lualine_b = {
      {
        'filename',
        path = 1,
        fmt = function(name)
          return vim.bo.filetype == 'fzf' and 'fzf' or name
        end,
      },
    },
    lualine_c = { 'branch', 'diagnostics' },
    lualine_x = { 'macro_recording', 'encoding' },
    lualine_y = { 'progress' },
    lualine_z = { 'location' },
  },
})

require('neo-tree').setup({
  close_if_last_window = true,
  popup_border_style = 'rounded',
  default_component_configs = {
    icon = {
      folder_closed = '+',
      folder_open = '-',
      folder_empty = '·',
      folder_empty_open = '·',
      default = '·',
      use_filtered_colors = true,
    },
    git_status = {
      symbols = {
        added = '+',
        deleted = '-',
        modified = '~',
        renamed = '>',
        untracked = '?',
        ignored = '!',
        unstaged = '*',
        staged = 's',
        conflict = 'x',
      },
    },
  },
  filesystem = {
    use_libuv_file_watcher = true,
    follow_current_file = { enabled = true },
    filtered_items = { hide_dotfiles = false },
    window = {
      mappings = {
        -- disable fuzzy finder
        ['/'] = 'noop',
      },
    },
  },
})
require('lsp-file-operations').setup()
vim.keymap.set('n', '<leader>e', function()
  if vim.bo.filetype == 'neo-tree' then
    vim.cmd('Neotree close')
  else
    vim.cmd('Neotree focus')
  end
end)

-- Leap
vim.keymap.set({ 'n', 'x', 'o' }, 's', '<Plug>(leap)')
vim.keymap.set('n', 'S', '<Plug>(leap-from-window)')

-- Incremental selection, see :h treesitter-incremental-selection
vim.keymap.set('n', '<A-o>', 'van', { remap = true })
vim.keymap.set('x', '<A-o>', 'an', { remap = true })
vim.keymap.set('x', '<A-i>', 'in', { remap = true })

-- Fzf-lua, helix-like layout: centered float, preview on the right
do
  local fzf = require('fzf-lua')
  fzf.setup({
    winopts = {
      height = 0.9,
      width = 0.9,
      row = 0.5,
      preview = { layout = 'horizontal', horizontal = 'right:50%' },
    },
    keymap = {
      builtin = {
        true,
        ['<C-u>'] = 'preview-half-page-up',
        ['<C-d>'] = 'preview-half-page-down',
      },
    },
    actions = {
      files = {
        true,
        ['ctrl-x'] = fzf.actions.file_split,
      },
    },
  })
  vim.keymap.set('n', '<leader>f', fzf.files)
  vim.keymap.set('n', '<leader>/', fzf.live_grep)
  vim.keymap.set('n', '<leader>d', fzf.diagnostics_workspace)

  -- Replace default qflist-based LSP pickers
  vim.keymap.set('n', 'grr', fzf.lsp_references)
  vim.keymap.set('n', 'gri', fzf.lsp_implementations)
  vim.keymap.set('n', 'grt', fzf.lsp_typedefs)
  vim.keymap.set('n', 'gO', fzf.lsp_document_symbols)
  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(ev)
      vim.keymap.set('n', '<C-]>', fzf.lsp_definitions, { buffer = ev.buf })
    end,
  })
end

-- Treesitter (parsers via tree-sitter-manager.nvim)
do
  require('tree-sitter-manager').setup({
    auto_install = true,
    nerdfont = false,
  })

  require('nvim-treesitter-textobjects').setup({
    select = { lookahead = true },
  })

  local select = require('nvim-treesitter-textobjects.select').select_textobject
  local move = require('nvim-treesitter-textobjects.move')
  -- nvim-treesitter-textobjects crashes on buffers without a parser (e.g. neo-tree).
  local function with_parser(fn)
    return function(...)
      if vim.treesitter.get_parser(0, nil, { error = false }) then
        fn(...)
      end
    end
  end
  local captures = {
    f = '@function',
    c = '@class',
    l = '@loop',
    i = '@conditional',
    p = '@parameter',
    s = '@call',
    a = '@assignment',
  }
  for key, capture in pairs(captures) do
    vim.keymap.set(
      { 'x', 'o' },
      'a' .. key,
      with_parser(function()
        select(capture .. '.outer', 'textobjects')
      end)
    )
    vim.keymap.set(
      { 'x', 'o' },
      'i' .. key,
      with_parser(function()
        select(capture .. '.inner', 'textobjects')
      end)
    )
    vim.keymap.set(
      { 'n', 'x', 'o' },
      ']' .. key,
      with_parser(function()
        move.goto_next_start(capture .. '.outer', 'textobjects')
      end)
    )
    vim.keymap.set(
      { 'n', 'x', 'o' },
      '[' .. key,
      with_parser(function()
        move.goto_previous_start(capture .. '.outer', 'textobjects')
      end)
    )
  end
end

-- lazydev — makes lua_ls aware of nvim's Lua API and plugins on rtp
require('lazydev').setup({
  library = {
    { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
  },
})

-- illuminate — highlights other occurrences of word under cursor
require('illuminate').configure({
  filetypes_denylist = {
    'neo-tree',
  },
})

-- Blink completion
require('blink.cmp').setup({
  completion = {
    keyword = { range = 'full' }, -- replace whole word, not just prefix
    list = { selection = { auto_insert = false } },
    menu = {
      draw = {
        align_to = 'cursor',
        columns = {
          { 'label' },
          { 'kind_icon', 'kind', gap = 1 },
          { 'label_description' },
        },
      },
    },
    documentation = {
      auto_show = true,
      auto_show_delay_ms = 0,
    },
  },
  keymap = {
    preset = 'none',
    ['<C-f>'] = { 'accept' },
    ['<C-n>'] = { 'select_next', 'snippet_forward' },
    ['<C-p>'] = { 'select_prev', 'snippet_backward' },
    ['<C-u>'] = { 'scroll_documentation_up' },
    ['<C-d>'] = { 'scroll_documentation_down' },
    ['<C-e>'] = { 'cancel' },
    ['<C-x>'] = { 'show' },
  },
  cmdline = {
    completion = {
      menu = { draw = { columns = { { 'label' } } } },
    },
  },
  sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = {
        name = 'LazyDev',
        module = 'lazydev.integrations.blink',
        score_offset = 100,
      },
    },
  },
})

-- Conform formatter
do
  local conform = require('conform')
  conform.setup({
    notify_on_error = false,
    formatters_by_ft = {
      lua = { 'stylua' },
      go = { 'gofumpt' },
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      dockerfile = { 'dockerfmt' },
      terraform = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      just = { 'just' },
      markdown = { 'rumdl' },
      tex = { 'tex-fmt' },
      yaml = { 'yamlfmt' },
    },
  })
  vim.keymap.set({ 'n', 'x' }, 'gq', function()
    conform.format({ async = true, lsp_format = 'fallback', quiet = true })
  end)
end

-- lsp

-- Filetypes nvim doesn't detect but helm_ls and docker_language_server expect
local function in_chart(path)
  return vim.fs.root(path, 'Chart.yaml') ~= nil
end
vim.filetype.add({
  filename = {
    ['compose.yaml'] = 'yaml.docker-compose',
    ['compose.yml'] = 'yaml.docker-compose',
    ['docker-compose.yaml'] = 'yaml.docker-compose',
    ['docker-compose.yml'] = 'yaml.docker-compose',
    ['docker-bake.hcl'] = 'hcl.docker-bake',
  },
  pattern = {
    ['.*/templates/.*%.ya?ml'] = function(path)
      return in_chart(path) and 'helm' or nil
    end,
    ['.*/templates/.*%.tpl'] = 'helm',
    ['.*/%.github/workflows/.*%.ya?ml'] = 'yaml.ghactions',
    ['.*/values.*%.ya?ml'] = function(path)
      return in_chart(path) and 'yaml.helm-values' or nil
    end,
  },
})

-- One server per YAML flavor: compose, helm values and workflows have their own
vim.lsp.config('yamlls', { filetypes = { 'yaml' } })

-- Homebrew ships the binary as actions-languageserver
vim.lsp.config('gh_actions_ls', {
  cmd = { 'actions-languageserver', '--stdio' },
  filetypes = { 'yaml.ghactions' },
})

vim.lsp.config('zizmor', { filetypes = { 'yaml', 'yaml.ghactions' } })

-- ty owns hover, see https://docs.astral.sh/ruff/editors/setup/#neovim
vim.lsp.config('ruff', {
  on_init = function(client)
    client.server_capabilities.hoverProvider = false
  end,
})

-- gopls already runs the vet analyzers
local golangci_cmd = vim.lsp.config.golangci_lint_ls.init_options.command --[[@as string[] ]]
vim.lsp.config('golangci_lint_ls', {
  init_options = {
    command = vim.list_extend(
      vim.deepcopy(golangci_cmd),
      { '--disable=govet' }
    ),
  },
})

vim.lsp.config('lua_ls', {
  settings = {
    Lua = {
      completion = {
        callSnippet = 'Replace',
        keywordSnippet = 'Replace',
      },
    },
  },
})

vim.lsp.config('ty', {
  init_options = {
    diagnosticMode = 'workspace',
  },
})

local servers = {
  'rust_analyzer',
  'bashls',
  'gopls',
  'golangci_lint_ls',
  'terraformls',
  'helm_ls',
  'rumdl',
  'docker_language_server',
  'texlab',
  'zls',
  'just',
  'ruff',
  'ty',
  'lua_ls',
  'jsonls',
  'html',
  'cssls',
  'eslint',
  'yamlls',
  'gh_actions_ls',
  'zizmor',
  'tombi',
}

vim.lsp.config('*', {
  capabilities = require('lsp-file-operations').default_capabilities(),
})
vim.lsp.enable(servers)
