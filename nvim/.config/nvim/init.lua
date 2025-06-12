-- REQUIREMENTS:
-- nvim v0.11+ (native LSP support)
-- ripgrep
-- fzf
-- compiledb (through pip to create compile_commands.json as needed for C/C++ LSP server)
-- clangd (C/C++ LSP server)
-- zls (zig LSP server)

-- Plugin management using vim-plug (vim script)
vim.cmd([[
  call plug#begin(stdpath('data') . '/plugged')

  " Display bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Fuzzy search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Auto tab/space detection & settings
  Plug 'https://github.com/tpope/vim-sleuth.git'

  " Nice commenting
  Plug 'https://github.com/tpope/vim-commentary.git'

  " Themes
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }
  Plug 'folke/tokyonight.nvim'

  " OSC52 support for copying text remotely
  Plug 'ojroques/nvim-osc52'

  " Syntax highlighting, folding, etc.
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

  " Helpful for using '.' to repeat plugin commands
  Plug 'https://github.com/tpope/vim-repeat.git'

  " Improved vim motions
  Plug 'https://github.com/ggandor/leap.nvim.git'

  " LSP and autocomplete
  Plug 'neovim/nvim-lspconfig'
  Plug 'hrsh7th/cmp-nvim-lsp'
  Plug 'hrsh7th/cmp-buffer'
  Plug 'hrsh7th/nvim-cmp'

  call plug#end()
]])

require("general")
require("keymaps")
require("appearance")
require("lsp")
