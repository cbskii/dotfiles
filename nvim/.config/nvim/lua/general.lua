-- General settings
vim.opt.syntax = "enable"                        -- Enable syntax
vim.opt.mouse = "n"                              -- Enable mouse for normal mode scrolling
vim.opt.ignorecase = true                        -- Ignore case when searching
vim.opt.smartcase = true                         -- Override ignorecase if search contains capitals
vim.opt.hlsearch = true                          -- Highlight search matches
vim.opt.backspace = { "indent", "eol", "start" } -- Better backspace behavior
vim.opt.wrap = true                              -- Enable line wrapping
vim.opt.textwidth = 97                           -- Auto format text to wrap at 97 chars
vim.opt.diffopt:append("vertical")               -- Vertical splits for diffs
vim.opt.clipboard:append("unnamedplus")          -- Use system clipboard
vim.opt.number = true                            -- Line numbers always visible
-- vim.opt.relativenumber = true                    -- Relative line numbers

-- Autocommand group for unusual file formats
vim.api.nvim_create_augroup("c_inc_ft", { clear = true })
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  group = "c_inc_ft",
  pattern = "*.c.inc",
  command = "set syntax=c",
})

-- FZF settings
vim.g.fzf_tags_command = "ctags -R"

-- Treesitter settings
require'nvim-treesitter.configs'.setup {
  -- A list of parser names that must always be installed
  ensure_installed = { "c", "cpp", "rust", "lua", "vim", "vimdoc" },

  highlight = {
    enable = true,
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      -- set to 'false' to disable a mapping
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}
