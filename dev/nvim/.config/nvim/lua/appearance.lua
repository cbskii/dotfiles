-- Settings that affect nvim appearance
vim.opt.colorcolumn = "100"
vim.opt.background = "dark"
vim.opt.termguicolors = true

-- Show spaces and tabs
vim.opt.list = true
vim.opt.listchars = {
  tab = "| ",
  space = "·",
  nbsp = "␣",
  trail = "•",
  precedes = "«",
  extends = "»",
}

-- Diagnostic popup
vim.diagnostic.config({
  virtual_text = false,     -- Show inline error messages
  signs = true,             -- Show signs (E, W, etc.) in the sign column
  underline = false,        -- Underline problematic code
  update_in_insert = false, -- Only update diagnostics outside of insert mode
  severity_sort = true,     -- Sort diagnostics by severity
  float = {
    border = "rounded",
    source = "always",
  },
})

-- Show diagnostic float automatically when hovering cursor over line.
-- Based on updatetime in ms.
vim.o.updatetime = 250
vim.api.nvim_create_autocmd({ "CursorHold" }, {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})

-- Always show sign column
vim.o.signcolumn = "yes"

-- Status bar settings
require('lualine').setup {
  options = {
    theme = 'auto',
    component_separators = '|',
    section_separators = { left = '', right = '' },
    disabled_filetypes = {'SidebarNvim'},
  },
  sections = {
    lualine_a = { { 'mode', separator = { left = '', right = '' }, right_padding = 2 } },
    lualine_b = {'branch', 'diff'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = { { 'progress', separator = { left = '', right = '' }, left_padding = 2 } },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {},
    lualine_z = {}
  },
}

-- Sidebar config
local cwd = {
  title = "Working Directory",
  icon = "",
  draw = function()
    return vim.fn.getcwd()
  end,
}

require("sidebar-nvim").setup({
  buffers = {
    icon = "",
    ignored_buffers = {},
    sorting = "id",
    show_numbers = true,
    ignore_not_loaded = false,
    ignore_terminal = true,
  },
  open = true,
  sections = {cwd, 'buffers', 'git'},
  update_interval = 100,
  hide_statusline = false,
})

-- Theme settings
require("catppuccin").setup({
  no_italic = true,    -- Force no italic
  no_bold = true,      -- Force no bold
  no_underline = true, -- Force no underline
})

-- vim.cmd.colorscheme("palenight")
-- vim.cmd.colorscheme("catppuccin")
vim.cmd.colorscheme("tokyonight")

-- Disable LSP semantic highlighting for now to avoid greyed out #ifdef blocks
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});
