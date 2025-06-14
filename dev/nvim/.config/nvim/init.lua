-- Plugin management using vim-plug (vim script)
vim.cmd([[
  call plug#begin(stdpath('data') . '/plugged')

  " Plugin Utility
  Plug 'nvim-lua/plenary.nvim'

  " Status bar
  Plug 'nvim-lualine/lualine.nvim'

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

  " Autoclose unused buffers
  Plug 'axkirillov/hbac.nvim'

  " Sidebar
  Plug 'sidebar-nvim/sidebar.nvim'

  " Open files in neovim terminal
  Plug 'willothy/flatten.nvim'

  call plug#end()
]])

require("general")
require("keymaps")
require("appearance")
require("lsp")
