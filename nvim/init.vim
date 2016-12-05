" Josh's vim configuration (http://github.com/knewter/dotfiles)

" Table of Contents
" 1) Basics #basics
"   1.1) Tabs #tabs
"   1.2) Leader #leader
" 2) Plugins #plugins
"   2.1) Filetypes #filetypes
"   2.2) Utilities #utilities
"   2.3) UI Plugins #ui-plugins
"   2.4) Code Navigation #code-navigation
" 3) UI Tweaks #ui-tweaks
"   3.1) Line numbering #line-numbering
"   3.2) Theme #theme

"""""""""""""" Basics #basics
""" Tabs #tabs
" - Two spaces wide
set tabstop=2
set softtabstop=2
" - Expand them all
set expandtab
" - Indent by 2 spaces by default
set shiftwidth=2

""" Misc
" set default encoding to UTF-8
set encoding=utf-8

" enable omni syntax completion
set omnifunc=syntaxcomplete#Complete

" turn off mouse
set mouse=""

""" Leader #leader
" Use comma for leader
let g:mapleader=','
" Double backslash for local leader - FIXME: not sure I love this
let g:maplocalleader='\\'
"""""""""""""" End Basics

"""""""""""""" Plugins #plugins
call plug#begin()

""" Filetypes #filetypes
" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'

" Elixir
Plug 'slashmili/alchemist.vim'

" Phoenix
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features


""" Utilities #utilities
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
  endif
  " use tab for completion
  inoremap <expr><tab> pumvisible() ? "\<c-n>" : "\<tab>"

""" UI Plugins #ui-plugins
" Molokai theme makes me cozy
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
" add ansi escape sequences
Plug 'powerman/vim-plugin-AnsiEsc'

""" Code Navigation #code-navigation
" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  nnoremap <silent> <C-P> :FZF<cr>

" Execute code checks, find mistakes, in the background
Plug 'neomake/neomake'
  " Run Neomake when I save any buffer
  augroup neomake
    autocmd! BufWritePost * Neomake
  augroup END
  " Don't tell me to use smartquotes in markdown ok?
  let g:neomake_markdown_enabled_makers = []

  " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
  let g:neomake_elixir_enabled_makers = ['mycredo']
  function! NeomakeCredoErrorType(entry)
    if a:entry.type ==# 'F'      " Refactoring opportunities
      let l:type = 'W'
    elseif a:entry.type ==# 'D'  " Software design suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'W'  " Warnings
      let l:type = 'W'
    elseif a:entry.type ==# 'R'  " Readability suggestions
      let l:type = 'I'
    elseif a:entry.type ==# 'C'  " Convention violation
      let l:type = 'W'
    else
      let l:type = 'M'           " Everything else is a message
    endif
    let a:entry.type = l:type
  endfunction

  let g:neomake_elixir_mycredo_maker = {
        \ 'exe': 'mix',
        \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
        \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
        \ 'postprocess': function('NeomakeCredoErrorType')
        \ }

" Easily manage tags files
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'


Plug 'tpope/vim-vinegar' " navigate up a directory with '-' in netrw, among other things

""""" Utilities ======================== #utilities
" EditorConfig support
Plug 'editorconfig/editorconfig-vim'

" Jump between quicklist, location (syntastic, etc) items with ease, among other things
Plug 'tpope/vim-unimpaired'

" Line commenting
Plug 'tomtom/tcomment_vim'
  " By default, `gc` will toggle comments
  "
Plug 'janko-m/vim-test'                " Run tests with varying granularity
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>

" Navigate between tmux panes and vim splits seamlessly
Plug 'christoomey/vim-tmux-navigator'
  " Handle <C-h> appropriately.
  " Details here: https://github.com/christoomey/vim-tmux-navigator#user-content-it-doesnt-work-in-neovim-specifically-c-h
  nnoremap <silent> <BS> :TmuxNavigateLeft<cr>
  " In essence: in neovim, <C-h> sends a backspace - this captures that in
  " normal mode and issues the left navigation command


" git support from dat tpope
Plug 'tpope/vim-fugitive'

" vim interface to web apis.  Required for gist-vim
Plug 'mattn/webapi-vim'

" create gists trivially from buffer, selection, etc.
Plug 'mattn/gist-vim'
  let g:gist_open_browser_after_post = 1
  let g:gist_detect_filetype = 2
  let g:gist_post_private = 1
  if has('macunix')
    let g:gist_clip_command = 'pbcopy'
  endif

" github support from dat tpope
Plug 'tpope/vim-rhubarb'

" visualize your undo tree
Plug 'sjl/gundo.vim'
  nnoremap <F5> :GundoToggle<CR>

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  let g:airline_theme= 'luna'
  let g:bufferline_echo = 0
  let g:airline_powerline_fonts=1
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0

call plug#end()
"""""""""""""" End Plugins

"""""""""""""" UI Tweaks #ui-tweaks
""" Line numbering #line-numbering
set number

""" Theme #theme
if (empty($TMUX))
  if (has("termguicolors"))
    set termguicolors
  endif
endif
set background=dark
syntax enable
colorscheme molokai

" hightlight cursor position
set cursorline
set cursorcolumn

" Highlight search results
set hlsearch
" Incremental search, search as you type
set incsearch
" Ignore case when searching
set ignorecase smartcase
" Ignore case when searching lowercase
set smartcase

" Set the title of the iterm tab
set title

""" Keyboard
" Remove highlights
" Clear the search buffer when hitting return
nnoremap <cr> :nohlsearch<cr>

" NO ARROW KEYS COME ON
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" Custom split opening / closing behaviour
map <C-N> :vsp .<CR>
map <C-C> :q<CR>

" reselect pasted content:
noremap gV `[v`]

" Keep the cursor in place while joining lines
nnoremap J mzJ`z

" Split line (sister to [J]oin lines above)
" The normal use of S is covered by cc, so don't worry about shadowing it.
nnoremap S i<cr><esc>^mwgk:silent! s/\v +$//<cr>:noh<cr>`w

" Open the alternate file
map ,, <C-^>

" Makes foo-bar considered one word
set iskeyword+=-

""" Auto Commands ====================== #auto-cmd
""""" Filetypes ========================
augroup erlang
  au!
  au BufNewFile,BufRead *.erl setlocal tabstop=4
  au BufNewFile,BufRead *.erl setlocal shiftwidth=4
  au BufNewFile,BufRead *.erl setlocal softtabstop=4
  au BufNewFile,BufRead relx.config setlocal filetype=erlang
augroup END

augroup elm
  au!
  au BufNewFile,BufRead *.elm setlocal tabstop=4
  au BufNewFile,BufRead *.elm setlocal shiftwidth=4
  au BufNewFile,BufRead *.elm setlocal softtabstop=4
augroup END

augroup dotenv
  au!
  au BufNewFile,BufRead *.envrc setlocal filetype=sh
augroup END

augroup es6
  au!
  au BufNewFile,BufRead *.es6 setlocal filetype=javascript
  au BufNewFile,BufRead *.es6.erb setlocal filetype=javascript
augroup END
""""" End Filetypes ====================

""""" Normalization ====================
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
au BufWrite * silent call DeleteTrailingWS()
""""" End Normalization ================
""" End Auto Commands ==================
