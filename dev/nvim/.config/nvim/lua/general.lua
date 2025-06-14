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
  ensure_installed = { "comment", "c", "cpp", "rust", "zig", "lua", "vim", "vimdoc" },

  highlight = {
    enable = true,
  },

  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
  },
}

-- HBAC settings
require("hbac").setup({
  autoclose     = true,
  threshold     = 10,
  close_command = function(bufnr)
    vim.api.nvim_buf_delete(bufnr, {})
  end,
  close_buffers_with_windows = false,
})

-- Flatten settings
require("flatten").setup({
  window = {
    open = "alternate",
  },
  hooks = {
    post_open = function(bufnr, winnr, ft, is_blocking)
      -- If the file is a git commit, create one-shot autocmd to delete its buffer on write
      if ft == "gitcommit" or ft == "gitrebase" then
        vim.api.nvim_create_autocmd("BufWritePost", {
          buffer = bufnr,
          once = true,
          callback = vim.schedule_wrap(function()
            vim.api.nvim_buf_delete(bufnr, {})
          end),
        })
      end
    end,
    block_end = function()
      -- After blocking ends (for a git commit, etc), reopen the terminal
      vim.schedule(function()
        if saved_terminal then
          saved_terminal:open()
          saved_terminal = nil
        end
      end)
    end,
  }
})
