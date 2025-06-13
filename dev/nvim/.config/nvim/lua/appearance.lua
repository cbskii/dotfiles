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
  sections = {
    lualine_a = {'mode'},
    lualine_b = {'branch'},
    lualine_c = {'filename'},
    lualine_x = {},
    lualine_y = {'progress'},
    lualine_z = {},
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

-- Custom sidebar terminals section
local renamed_terminals = {}

vim.api.nvim_create_autocmd("BufFilePost", {
  pattern = "*",
  callback = function()
    local bufnr = vim.api.nvim_get_current_buf()
    if vim.bo[bufnr].buftype == "terminal" and vim.api.nvim_buf_get_name(bufnr) ~= "" then
      renamed_terminals[bufnr] = vim.api.nvim_buf_get_name(bufnr)
    end
  end
})

local function get_renamed_terminals()
  local lines = {}
  for bufnr, name in pairs(renamed_terminals) do
    local shortname = vim.fn.fnamemodify(name, ":t")
    table.insert(lines, shortname)
  end
  return lines
end

local terms = {
  title = "Terminals",
  icon = "",
  draw = function(ctx)
    local lines = get_renamed_terminals()
    if #lines == 0 then
      return { "No renamed terminals" }
    end
    return lines
  end,
}

-- Sidebar config
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
  -- sections = {terms, 'git', 'buffers'},
  sections = {'git', 'buffers'},
  update_interval = 100,
  hide_statusline = false, -- buggy
})

-- Theme settings
require("catppuccin").setup({
  no_italic = true,    -- Force no italic
  no_bold = true,      -- Force no bold
  no_underline = true, -- Force no underline
})

vim.cmd.colorscheme("catppuccin")

-- Disable LSP semantic highlighting for now to avoid greyed out #ifdef blocks
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
});
