" Don't run Vim-Plug if on NixOS or using another plugin manager
if ! empty(globpath(&rtp, 'autoload/plug.vim'))
  " Plugins will be downloaded under the specified directory.
  call plug#begin(stdpath('data') . '/plugged')

  " Display bar
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'

  " Fuzzy search
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'

  " Nvim LSP
  Plug 'neovim/nvim-lspconfig' " https://github.com/neovim/nvim-lspconfig

  " C/C++ support
  Plug 'bfrg/vim-cpp-modern'

  " Rust support
  Plug 'rust-lang/rust.vim'

  " Zig support
  Plug 'ziglang/zig.vim'       " https://github.com/ziglang/zig.vim

  " TOML support
  Plug 'cespare/vim-toml', { 'branch': 'main' }

  " Bitbake syntax support
  Plug 'https://github.com/kergoth/vim-bitbake.git'

  " Auto tab/space detection & settings
  Plug 'https://github.com/tpope/vim-sleuth.git'

  " Nice commenting
  Plug 'https://github.com/tpope/vim-commentary.git'

  " Themes
  Plug 'drewtempelmeyer/palenight.vim'
  Plug 'catppuccin/nvim', { 'as': 'catppuccin' }

  " OSC52 support for copying text remotely
  Plug 'ojroques/vim-oscyank'

  " List ends here. Plugins become visible to Vim after this call.
  call plug#end()
endif

" General settings
syntax enable                           " Enable syntax
set mouse=n                             " Enable mouse for normal mode scrolling
set ignorecase                          " Ignore case when searching
set smartcase                           " Ignore case when searching unless using capitals
set hlsearch                            " Highlight searches
set backspace=indent,eol,start          " Make backspace work as expected
set nowrap                              " Disable visual line wrapping
set timeoutlen=1000 ttimeoutlen=0       " Remove delay after pressing esc
set textwidth=97                        " Auto format text to wrap at < 100 chars
set wrap                                " Automatic line wrapping
set diffopt+=vertical                   " Vertical splits for diffs

" Show spaces and tabs
set list
set listchars=tab:\|\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»

" General remaps
nnoremap <esc><esc> :silent! nohls<cr> " unhighlight searches map
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap <C-u> u
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <C-t> :Tags<CR>
nnoremap <silent> <C-e> :Buffers<CR>
nnoremap <silent> <C-s> :Rg <C-R><C-W><CR>
nnoremap <Tab> :b#<CR>
noremap d <C-D>
noremap u <C-U>
tnoremap <esc> <C-\><C-n>

" Try to make search direction consistent
nnoremap n :/<CR>
nnoremap N :?<CR>

" Line numbers - automatically switch between relative and normal
set number relativenumber
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" FZF settings
let g:fzf_tags_command = 'ctags -R'

" Airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#gutentags#enabled = 1

" Theme settings
set colorcolumn=100
set background=dark
set termguicolors
lua << EOF
require("catppuccin").setup({
  no_italic = true,
  no_bold = true,
  no_underline = true,
})
EOF
colorscheme catppuccin
let g:airline_theme='catppuccin'

" Make normal yank also use OSC 52 for remote copy
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif

" Unusual file formats
augroup c_inc_ft
  au!
  autocmd BufNewFile,BufRead *.c.inc   set syntax=c
augroup END

" Rust LSP settings
" lua require'lspconfig'.rust_analyzer.setup({})

" Zig LSP config
" disable format-on-save from `ziglang/zig.vim`
let g:zig_fmt_autosave = 1
" don't show parse errors in a separate window
let g:zig_fmt_parse_errors = 1

:lua << EOF
  -- enable format-on-save from nvim-lspconfig + ZLS
  --
  -- ZLS uses `zig fmt` as the formatter.
  -- The Zig FAQ answers some questions about `zig fmt`:
  -- https://github.com/ziglang/zig/wiki/FAQ
  vim.cmd [[autocmd BufWritePre *.zig lua vim.lsp.buf.format()]]

  local lspconfig = require('lspconfig')
  lspconfig.zls.setup {
    -- Server-specific settings. See `:help lspconfig-setup`
    -- There are two ways to set config options:
    --   - edit your `zls.json` that applies to any editor that uses ZLS
    --   - set in-editor config options with the `settings` field below.
    --
    -- Further information on how to configure ZLS:
    -- https://github.com/zigtools/zls/wiki/Configuration
    settings = {
      zls = {
      }
    }
  }
EOF
