filetype off

" --------------- Plugins installed ------------------------------------------- "
call plug#begin('~/.vim/plugged')

" YouCompleteMe disabled by default.
" Uncomment and run :PlugInstall to install it.
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'scrooloose/syntastic'
Plug 'andreamichi/base16-vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'tomtom/tcomment_vim'
Plug 'vim-scripts/a.vim', {'for': ['cpp', 'c'] }
Plug 'airblade/vim-gitgutter'
Plug 'plasticboy/vim-markdown'
Plug 'ntpeters/vim-better-whitespace'
Plug 'kien/ctrlp.vim'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'SirVer/ultisnips'

" Plugins for Neovim.
if has('nvim')
  Plug 'kassio/neoterm'
endif

call plug#end()

syntax on
filetype plugin indent on

set background=dark
colorscheme default


" --------------- Indentation and Formatting ----------------------------------

set autoindent      " Copy indent from current line when starting a new one.
set smartindent     " Smart autoindenting when starting a new line.
set smarttab        " <Tab> depends on the value of 'shiftwidth'.
set expandtab       " Use appropriate number of spaces rather than tab.
set shiftround      " Round indent to multiple of shiftwidth.
set nowrap          " Don't wrap lines longer than width of the window>
set scrolloff=5     " minimal number of lines above/below cursor on scrolling.
set tabstop=2       " number of spaces that a <Tab> counts for normally.
set softtabstop=2   " number of spaces that a <Tab> counts for while editing.
set shiftwidth=2    " Values used by smarttab setting.

" Default indentation and folding settings for specific languages.
augroup indentation
autocmd FileType html       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType ruby       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType python     setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType java       setlocal shiftwidth=2 tabstop=2 softtabstop=2
autocmd FileType go         setlocal noexpandtab
augroup END


" --------------- General Settings --------------------------------------------

set backspace=indent,eol,start " Allow backspace over everything in insert mode.

set number          " Activate the number on the left.
set ruler           " Show line and column number of the cursor position.
set showcmd         " Show partial command in the last line of the screen.
set nostartofline   " Keep the cursor on the same column when moving.

set nobackup        " Do not create backup files.
set noswapfile      " Do not create swap files.

set history=128     " History level.
set undolevels=512  " Number of undo available.
set autoread        " Reload file when changed on disk (e.g. git checkout).

set fdm=manual      " Folding method used.
set foldlevel=99    " Folding level.

set splitbelow      " Open orizontal split on the bottom.
set splitright      " Open vertical split on the right.

let mapleader=","   " Change the mapleader from '\' to ','.


" --------------- Navigation Settings ------------------------------------------

" Terminal configuration (Neovim).
if exists(':tnoremap')
  tnoremap <A-h> <C-\><C-n><C-w>h
  tnoremap <A-j> <C-\><C-n><C-w>j
  tnoremap <A-k> <C-\><C-n><C-w>k
  tnoremap <A-l> <C-\><C-n><C-w>l

  " If the buffer is a terminal default to Insert mode.
  au BufEnter * if &buftype == 'terminal' | :startinsert | endif
endif

nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l

" --------------- Searching Settings ------------------------------------------

" Searching is not case sensitive when the pattern contains only lower
" case letters (defined by set ignorecase). However, in the presence of
" upper case letters, the search becomes case sensitive.

set hlsearch        " highlight all matches of a search pattern.
set incsearch       " Show where the pattern, while typying a search command.
set smartcase       " Override 'ignorecase' for upper case search patterns.
set ignorecase      " Ignore case of normal letters.

" Use <C-l> to clear the highlighting of :set hlsearch.
nnoremap <silent> <C-l> :nohlsearch<CR>


" --------------- Copy/Paste Settings ------------------------------------------

set clipboard=unnamedplus

" Copy to clipboard
vnoremap  <Leader>y  "+y
nnoremap  <Leader>Y  "+yg_
nnoremap  <Leader>y  "+y
nnoremap  <Leader>yy  "+yy

" Paste from clipboard
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
inoremap <Leader>p <ESC>"+p
inoremap <Leader>P <ESC>"+P


" --------------- Miscellaneous Settings -------------------------------------

" Easier access to the <ESC>.
inoremap jk <ESC>

" Move to back and forward through buffer.
nnoremap <silent> <C-b> :bp<CR>
nnoremap <silent> <C-n> :bn<CR>

" CtrlP working directory is the nearest ancestor (directory with .git) or
" the current working directory.
let g:ctrlp_working_path_mode = 'ra'

" Ctrlp will ignore these files.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" Set clang and c++ for syntastic.
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

" Removing YouCompleteMe preview window.
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

" Close preview window when done.
autocmd CompleteDone * pclose

" Ultisnips configuration.
let g:UltiSnipsExpandTrigger = "<c-j>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"


" --------------- Git Settings ------------------------------------------------

" Set 1 to start vim-gitgutter by default
let g:gitgutter_enabled = 0

" Enabled/Disabled'
map <Leader>g :GitGutterToggle<CR>

" Automatically wrap at 72 characters and spell check git commit messages
augroup git
autocmd FileType gitcommit setlocal textwidth=72
autocmd FileType gitcommit setlocal spell
augroup END


" --------------- Markdown Settings -------------------------------------------

" Markdown olding method.
autocmd BufEnter *.md       setlocal foldexpr=MarkdownFolding()

let g:vim_markdown_folding_disabled=1

" Mapping to space to fold toggle.
nnoremap <Space> za

function! MarkdownFolding()
  let h = matchstr(getline(v:lnum), '^#\+')
  if empty(h)
    return "="
  else
    return ">" . len(h)
  endif
endfunction

" Wrap text with markdown and don't write more than 80 chars width.
autocmd BufRead,BufNewFile *.md setlocal wrap textwidth=80

" --------------- Eclim Settings ---------------------------------------------
nnoremap <Leader>ji :JavaImport<CR>
nnoremap <Leader>jr :JavaRename<CR>

" --------------- Local vimrc ------------------------------------------------
if !empty(glob("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
