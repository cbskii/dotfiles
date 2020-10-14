" General notes:
" 1. Use Neovim instead of Vim
" 2. Plugin manager is vim-plug
" 3. Assuming Vim is running on Unix/Linux

" TODO check for nvim vs vim and handle appropriately

" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Display bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Python PEP8 linter
Plug 'https://github.com/nvie/vim-flake8.git'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }

" Autocompletion engine - READ INSTALLATION MANUAL IF THIS FAILS
" Notes: This is a heavy plugin and may be best to leave if not needed. For C/C++
" it requires clangd to be installed and "bear" can be used to generate
" compile_commands.json for non-Cmake build systems to use with YCM.
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clangd-completer' }

" Auto tab/space detection & settings
Plug 'https://github.com/tpope/vim-sleuth.git'

" Nice commenting
Plug 'https://github.com/tpope/vim-commentary.git'

" Themes
Plug 'drewtempelmeyer/palenight.vim'
Plug 'morhetz/gruvbox'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

" General settings
syntax enable  " enable syntax
set mouse=a  " make mouse work as expected
set clipboard=unnamedplus " copy to system clipboard by default
set ignorecase  " ignore case when searching
set smartcase  " ignore case when searching unless using capitals
set hlsearch  " highlight searches
nnoremap <esc><esc> :silent! nohls<cr>  " unhighlight searches map
set backspace=indent,eol,start  " make backspace work as expected
set nowrap  " disable visual line wrapping
set t_Co=256  " ensure 256 color terminal
set timeoutlen=1000 ttimeoutlen=0  " remove delay after pressing esc
set textwidth=97  " Auto format text to wrap at < 100 chars

" Show spaces and tabs
set list
set listchars=tab:\|\ ,space:·,nbsp:␣,trail:•,precedes:«,extends:»

" Remaps
nnoremap <C-J> <C-W><C-J>
nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>
nnoremap U <C-r>
nnoremap <silent> <C-p> :FZF<CR>
nnoremap <silent> <C-r> :Tags<CR>
nnoremap <silent> <C-e> :Buffers<CR>
nnoremap <silent> <C-s> :Rg <C-R><C-W><CR>
nnoremap <Tab> :b#<CR>

" File exploration
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_winsize = 25

" Line number settings - auto change
set number relativenumber " enable line numbers
:augroup numbertoggle
:  autocmd!
:  autocmd BufEnter,FocusGained,InsertLeave * set relativenumber
:  autocmd BufLeave,FocusLost,InsertEnter   * set norelativenumber
:augroup END

" FZF settings
let g:fzf_tags_command = 'ctags -R'

" airline settings
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'
let g:airline_powerline_fonts = 1

" YCM settings
let g:ycm_clangd_uses_ycmd_caching = 0 " Let clangd fully control code completion
let g:ycm_clangd_binary_path = "/usr/bin/clangd-9" " `whereis clangd-9`

" Theme settings
set colorcolumn=100
set background=dark
colorscheme palenight
let g:airline_theme='palenight'
set termguicolors
