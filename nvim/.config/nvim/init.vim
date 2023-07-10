" Plugins will be downloaded under the specified directory.
call plug#begin(stdpath('data') . '/plugged')

" Display bar
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" Fuzzy search
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" C/C++ support
Plug 'bfrg/vim-cpp-modern'

" Rust support
Plug 'rust-lang/rust.vim'

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

" OSC52 support for copying text remotely
Plug 'ojroques/vim-oscyank'

" List ends here. Plugins become visible to Vim after this call.
call plug#end()

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
colorscheme palenight
let g:airline_theme='palenight'

" Make normal yank also use OSC 52 for remote copy
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | OSCYankReg " | endif

" Unusual file formats
augroup c_inc_ft
  au!
  autocmd BufNewFile,BufRead *.c.inc   set syntax=c
augroup END
