set nocompatible
filetype plugin on
syntax on

set rtp+=~/.vim/bundle/vundle
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-rails'
Bundle 'mileszs/ack.vim'
Bundle 'spolu/dwm.vim'
Bundle 'int3/vim-extradite'
Bundle 'walm/jshint.vim'
Bundle 'alunny/pegjs-vim'
Bundle 'altercation/vim-colors-solarized'
Bundle 'kchmck/vim-coffee-script'
Bundle 'jtratner/vim-flavored-markdown'
Bundle 'tpope/vim-markdown'
Bundle 'reusee/vim.rust'
Bundle 'slim-template/vim-slim'
Bundle 'jasonkuhrt/Tomorrow-Theme'

let g:vimwiki_use_mouse=0
Bundle 'vim-scripts/vimwiki'

" handle 256 colors in gnome terminal
set t_Co=256

let mapleader = ","

" Set encoding
set encoding=utf-8

" Whitespace stuff
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab

" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

" Open the alternate file
map ,, <C-^>

" Tab completion
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.class,.svn,vendor/gems/*

" Status bar
set laststatus=2

" Font
set guifont="Terminus\ 9"

" Show trailing whitespace and spaces before a tab:
:highlight ExtraWhitespace ctermbg=red guibg=red
:autocmd Syntax * syn match ExtraWhitespace /\s\+$\| \+\ze\\t/

" Support github flavored markdown automatically
augroup markdown
  au!
  au BufNewFile,BufRead *.md,*.markdown setlocal filetype=ghmarkdown
augroup END

" Turn off menu in gui
set guioptions="agimrLt"
" Turn off mouse click in gui
set mouse=""

" Theme...
set background=dark
colorscheme Tomorrow-Night-Eighties

" highlight the current line
set cursorline
" Highlight active column
set cuc cul

" Show linenumbers
set number
set ruler

set columns=80
set textwidth=80

au BufReadPost *.thor set syntax=ruby

" Ack bits
map <leader>a :Ack! -ai 

" vimwiki config
nmap <Leader>wf <Plug>VimwikiFollowLink

" Remove highlights
nmap <Leader><CR> :nohlsearch<cr>
