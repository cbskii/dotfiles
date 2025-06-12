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
  float = {
    border = "rounded",
    source = "always",
  },
  update_in_insert = true,
})

-- Always show sign column
vim.o.signcolumn = "yes"

-- Airline settings
vim.g["airline#extensions#tabline#enabled"] = 1
vim.g["airline#extensions#tabline#buffer_nr_show"] = 1
vim.g["airline#extensions#tabline#formatter"] = "unique_tail"
vim.g.airline_powerline_fonts = 1
vim.g["airline#extensions#fzf#enabled"] = 1
vim.g["airline#extensions#gutentags#enabled"] = 1
vim.g.airline_theme = "catppuccin"

-- Theme settings
require("catppuccin").setup({
  no_italic = true,    -- Force no italic
  no_bold = true,      -- Force no bold
  no_underline = true, -- Force no underline
})

vim.cmd.colorscheme("catppuccin")
