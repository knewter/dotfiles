scriptencoding utf-8
" Josh's vim configuration (http://github.com/knewter/dotfiles)

" Table of Contents
" 1) Basics #basics
"   1.1) Tabs #tabs
"   1.2) Format Options #format-options
"   1.3) Leader #leader
"   1.4) Omni #omni
"   1.5) UI Basics #ui-basics
" 2) Plugins #plugins
"   2.1) Filetypes #filetypes
"   2.2) Utilities #utilities
"   2.3) UI Plugins #ui-plugins
"   2.4) Code Navigation #code-navigation
" 3) UI Tweaks #ui-tweaks
"   3.1) Theme #theme
" 4) Navigation #navigation

"""""""""""""" Basics #basics
""" Tabs #tabs
" - Two spaces wide
set tabstop=2
set softtabstop=2
" - Expand them all
set expandtab
" - Indent by 2 spaces by default
set shiftwidth=2

""" Format Options #format-options
set formatoptions=tcrq
set textwidth=80

""" Handling backup copies
" make a copy of the file and overwrite the original one
set backupcopy=yes

""" Leader #leader
" Use space for leader
let g:mapleader=' '
" Double backslash for local leader
let g:maplocalleader='\\'

""" omni #omni
" enable omni syntax completion
set omnifunc=syntaxcomplete#Complete

""" UI Basics #ui-basics
" turn off mouse
set mouse=""

" NOTE: I stopped highlighting cursor position because it makes redrawing
" super slow.
" set cursorline
" set cursorcolumn

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

" Line numbering
set number

""" Undo #undo
" undofile - This allows you to use undos after exiting and restarting
" This, like swap and backups, uses .vim-undo first, then ~/.vim/undo
" :help undo-persistence
" This is only present in 7.3+
if isdirectory($HOME . '/.config/nvim/undo') == 0
  :silent !mkdir -p ~/.config/nvim/undo > /dev/null 2>&1
endif
set undodir=./.vim-undo//
set undodir+=~/.vim/undo//
set undofile

"""""""""""""" End Basics

"""""""""""""" Plugins #plugins
call plug#begin()

""" Filetypes #filetypes
" Polyglot loads language support on demand!
Plug 'sheerun/vim-polyglot'
  let g:polyglot_disabled = ['elm']

" HTML / JS / CSS
Plug 'othree/html5.vim'
Plug 'html-improved-indentation'
Plug 'pangloss/vim-javascript'
Plug 'flowtype/vim-flow'
Plug 'wokalski/autocomplete-flow'
" For func argument completion
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Elixir
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim'
""" Add support for ANSI colors - this has variously been necessary and caused
""" problems, no clue what's up there...
  Plug 'powerman/vim-plugin-AnsiEsc'

" Phoenix
Plug 'c-brenn/phoenix.vim'
Plug 'tpope/vim-projectionist' " required for some navigation features

" Elm
Plug 'ElmCast/elm-vim'
  let g:elm_format_autosave = 1
  let g:elm_detailed_complete = 1
  let g:elm_syntastic_show_warnings = 1
  let g:elm_format_fail_silently = 1
  let g:elm_browser_command = 'open'
  let g:elm_make_show_warnings = 1
  let g:elm_setup_keybindings = 1

" Fuse
Plug 'BeeWarloc/vim-fuse'

" Markdown
function! NpmInstallAndUpdateRemotePlugins(info)
  !npm install
  UpdateRemotePlugins
endfunction
Plug 'neovim/node-host', { 'do': function('NpmInstallAndUpdateRemotePlugins') }
Plug 'vimlab/mdown.vim', { 'do': function('NpmInstallAndUpdateRemotePlugins') }

""" Utilities #utilities
Plug 'bogado/file-line'

" Easily toggle quickfix and locations lists with <leader>l and <leader>q
Plug 'milkypostman/vim-togglelist'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
  let g:deoplete#enable_at_startup = 1
  let g:deoplete#sources = {}
  let g:deoplete#sources._ = ['file', 'neosnippet']
  let g:deoplete#omni#functions = {}
  let g:deoplete#omni#input_patterns = {}

  " Elm support
  " h/t https://github.com/ElmCast/elm-vim/issues/52#issuecomment-264161975
  let g:deoplete#sources.elm = ['omni'] + g:deoplete#sources._
  let g:deoplete#omni#functions.elm = ['elm#Complete']
  let g:deoplete#omni#input_patterns.elm = '[^ \t]+'
  let g:deoplete#disable_auto_complete = 1

Plug 'ervandew/supertab'

" Add comment textobjects (I really want to reformat comments without affecting
" the next line of code)
Plug 'kana/vim-textobj-user' | Plug 'glts/vim-textobj-comment'
  " Example: Reformat a comment with `gqac` (ac is "a comment")

" EditorConfig support
Plug 'editorconfig/editorconfig-vim'

" Jump between quicklist, location (syntastic, etc) items with ease, among other things
Plug 'tpope/vim-unimpaired'

" Line commenting
Plug 'tomtom/tcomment_vim'
  " By default, `gc` will toggle comments

Plug 'janko-m/vim-test'                " Run tests with varying granularity
  nmap <silent> <leader>t :TestNearest<CR>
  nmap <silent> <leader>T :TestFile<CR>
  nmap <silent> <leader>a :TestSuite<CR>
  nmap <silent> <leader>l :TestLast<CR>
  nmap <silent> <leader>g :TestVisit<CR>
  " run tests in neoterm
  let g:test#strategy = 'neoterm'
  " I use spinach, not cucumber!
  let g:test#ruby#cucumber#executable = 'spinach'

" Asynchronous file linter
Plug 'w0rp/ale'
  " wait a bit before checking syntax in a file, if typing
  let g:ale_lint_delay = 5000
  " Use global eslint
  let g:ale_javascript_eslint_use_global = 1
  " Only use es6 for js
  let g:ale_linters = {'javascript': ['eslint']}

" git support from dat tpope
Plug 'tpope/vim-fugitive'

" github support from dat tpope
Plug 'tpope/vim-rhubarb'

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

" visualize your undo tree
Plug 'sjl/gundo.vim'
  nnoremap <F5> :GundoToggle<CR>

" org-mode
Plug 'jceb/vim-orgmode'
  let g:org_agenda_files = ['~/org/index.org']
  let g:org_export_emacs = '/usr/local/bin/emacs'
  let g:org_export_verbose = 1

" universal text linking
Plug 'vim-scripts/utl.vim'

" allow portions of a file to use different syntax
Plug 'vim-scripts/SyntaxRange'

" increment dates like other items
Plug 'tpope/vim-speeddating'

" calendar application
Plug 'itchyny/calendar.vim'
  let g:calendar_google_calendar = 1
  let g:calendar_google_task = 1

" nicer api for neovim terminal
Plug 'kassio/neoterm'


""" UI Plugins #ui-plugins
" Molokai theme makes me cozy
Plug 'tomasr/molokai'
Plug 'fmoralesc/molokayo'
" Try out the ayu theme - https://github.com/ayu-theme/ayu-vim
Plug 'ayu-theme/ayu-vim'
" Solarized - variant with specific terminal support
Plug 'lifepillar/vim-solarized8'

Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
  "let g:airline_theme = 'luna'
  "let g:airline_theme = 'lucius'
  let g:airline_theme = 'solarized'
  let g:bufferline_echo = 0
  let g:airline_powerline_fonts=0
  let g:airline_enable_branch=1
  let g:airline_enable_syntastic=1
  let g:airline_branch_prefix = '⎇ '
  let g:airline_paste_symbol = '∥'
  let g:airline#extensions#tabline#enabled = 0

""" Code Navigation #code-navigation
" fzf fuzzy finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
  let g:fzf_layout = { 'window': 'enew' }
  nnoremap <silent> <C-P> :FZF<cr>
  nnoremap <silent> <leader>a :Ag<cr>
  augroup localfzf
    autocmd!
    autocmd FileType fzf :tnoremap <buffer> <C-J> <C-J>
    autocmd FileType fzf :tnoremap <buffer> <C-K> <C-K>
    autocmd VimEnter * command! -bang -nargs=* Ag
      \ call fzf#vim#ag(<q-args>,
      \                 <bang>0 ? fzf#vim#with_preview('up:60%')
      \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
      \                 <bang>0)
  augroup END

" Open files where you last left them
Plug 'dietsche/vim-lastplace'

" Execute code checks, find mistakes, in the background
" Plug 'neomake/neomake'
"   " Run Neomake when I save any buffer
"   augroup localneomake
"     autocmd! BufWritePost * Neomake
"   augroup END
"   " Don't tell me to use smartquotes in markdown ok?
"   let g:neomake_markdown_enabled_makers = []
"
"   " Configure a nice credo setup, courtesy https://github.com/neomake/neomake/pull/300
"   let g:neomake_elixir_enabled_makers = ['mix', 'mycredo']
"   function! NeomakeCredoErrorType(entry)
"     if a:entry.type ==# 'F'      " Refactoring opportunities
"       let l:type = 'W'
"     elseif a:entry.type ==# 'D'  " Software design suggestions
"       let l:type = 'I'
"     elseif a:entry.type ==# 'W'  " Warnings
"       let l:type = 'W'
"     elseif a:entry.type ==# 'R'  " Readability suggestions
"       let l:type = 'I'
"     elseif a:entry.type ==# 'C'  " Convention violation
"       let l:type = 'W'
"     else
"       let l:type = 'M'           " Everything else is a message
"     endif
"     let a:entry.type = l:type
"   endfunction
"
"   let g:neomake_elixir_mycredo_maker = {
"         \ 'exe': 'mix',
"         \ 'args': ['credo', 'list', '%:p', '--format=oneline'],
"         \ 'errorformat': '[%t] %. %f:%l:%c %m,[%t] %. %f:%l %m',
"         \ 'postprocess': function('NeomakeCredoErrorType')
"         \ }

" Easily manage tags files
Plug 'ludovicchabant/vim-gutentags'
  let g:gutentags_cache_dir = '~/.tags_cache'

" navigate up a directory with '-' in netrw, among other things
Plug 'tpope/vim-vinegar'

" vifm file manager as the default vim file management tool
" Plug 'vifm/neovim-vifm'
" NOTE: I don't get highlighting with this and it's hard to see where the
" selection is

call plug#end()

"" Plugin configuration that has to run after plug#end

"""""""""""""" End Plugins


"""""""""""""" UI Tweaks #ui-tweaks
""" Theme #theme
if (empty($TMUX))
  if (has('termguicolors'))
    set termguicolors
  endif
endif
set background=dark
"set background=light
syntax enable
"colorscheme molokai

" Ayu theme config
"let ayucolor="light"  " for light version of theme
"let ayucolor="mirage" " for mirage version of theme
" let ayucolor="dark"   " for dark version of theme
" colorscheme ayu
colorscheme solarized8_light_flat
"colorscheme solarized8_dark_flat

""" Keyboard
" Remove highlights
" Clear the search buffer when hitting return
nnoremap <silent> <cr> :nohlsearch<cr>

" NO ARROW KEYS COME ON
map <Left>  :echo "no!"<cr>
map <Right> :echo "no!"<cr>
map <Up>    :echo "no!"<cr>
map <Down>  :echo "no!"<cr>

" Custom split opening / closing behaviour
map <C-N> :vsp<CR><C-P>
map <C-C> :q<CR>
" Custom tab opening behaviour
map <leader>n :tabnew .<CR><C-P>

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

" A helper function to restore cursor position, window position, and last search
" after running a command.  From:
" http://stackoverflow.com/questions/15992163/how-to-tell-vim-to-auto-indent-before-saving
function! Preserve(command)
  " Save the last search.
  let search = @/

  " Save the current cursor position.
  let cursor_position = getpos('.')

  " Save the current window position.
  normal! H
  let window_position = getpos('.')
  call setpos('.', cursor_position)

  " Execute the command.
  execute a:command

  " Restore the last search.
  let @/ = search

  " Restore the previous window position.
  call setpos('.', window_position)
  normal! zt

  " Restore the previous cursor position.
  call setpos('.', cursor_position)
endfunction

" Re-indent the whole buffer.
function! Indent()
  call Preserve('normal gg=G')
endfunction

""""" Filetypes ========================
augroup erlang
  autocmd!
  autocmd BufNewFile,BufRead *.erl setlocal tabstop=4
  autocmd BufNewFile,BufRead *.erl setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.erl setlocal softtabstop=4
  autocmd BufNewFile,BufRead relx.config setlocal filetype=erlang
augroup END

" augroup elixir
"   autocmd!
"   " autocmd BufWritePre *.ex call Indent()
"   " autocmd BufWritePre *.exs call Indent()
"   "
"   " Sadly, I can't enable auto-indent for elixir because it messes up my heredoc
"   " indentation for code sections and it has a couple of other issues :(
"   autocmd BufNewFile,BufRead *.ex setlocal formatoptions=tcrq
"   autocmd BufNewFile,BufRead *.exs setlocal formatoptions=tcrq
" augroup END

augroup elm
  autocmd!
  autocmd BufNewFile,BufRead *.elm setlocal tabstop=4
  autocmd BufNewFile,BufRead *.elm setlocal shiftwidth=4
  autocmd BufNewFile,BufRead *.elm setlocal softtabstop=4
augroup END

augroup dotenv
  autocmd!
  autocmd BufNewFile,BufRead *.envrc setlocal filetype=sh
augroup END

augroup es6
  autocmd!
  autocmd BufNewFile,BufRead *.es6 setlocal filetype=javascript
  autocmd BufNewFile,BufRead *.es6.erb setlocal filetype=javascript
augroup END

augroup markdown
  autocmd!
  autocmd FileType markdown setlocal textwidth=80
  autocmd FileType markdown setlocal formatoptions=tcrq
  autocmd FileType markdown setlocal spell spelllang=en
augroup END

augroup viml
  autocmd!
  autocmd FileType vim setlocal textwidth=80
  autocmd FileType vim setlocal formatoptions=tcrq
augroup END
""""" End Filetypes ====================

""""" Normalization ====================
" Delete trailing white space on save
func! DeleteTrailingWS()
  exe 'normal mz'
  %s/\s\+$//ge
  exe 'normal `z'
endfunc

augroup whitespace
  autocmd BufWrite * silent call DeleteTrailingWS()
augroup END
""""" End Normalization ================
""" End Auto Commands ==================

""" Navigation ====================== #navigation
" Navigate terminal with C-h,j,k,l
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l

" Navigate splits with C-h,j,k,l
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l
nnoremap <silent> <BS> <C-w>h
  " Have to add this because hyperterm sends backspace for C-h

" Navigate tabs with leader+h,l
" It's hard to hit space and h/l simultaneously so increase the timeout for
" space
nnoremap <leader>h :tabprev<cr>
nnoremap <leader>l :tabnext<cr>
""" End Navigation ==================
