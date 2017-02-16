filetype off

" --------------- Plugins installed ------------------------------------------- "
call plug#begin('~/.vim/plugged')

" YouCompleteMe disabled by default.
" Uncomment and run :PlugInstall to install it.
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py' }

Plug 'andreamichi/base16-vim'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'easymotion/vim-easymotion'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'ntpeters/vim-better-whitespace'
Plug 'plasticboy/vim-markdown'
Plug 'scrooloose/nerdtree'
Plug 'scrooloose/syntastic'
Plug 'SirVer/ultisnips'
Plug 'tomtom/tcomment_vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'vim-scripts/a.vim', {'for': ['cpp', 'c'] }

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
  autocmd!
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

" Copy to clipboard.
vnoremap  <Leader>y  "+y
nnoremap  <Leader>Y  "+yg_
nnoremap  <Leader>y  "+y
nnoremap  <Leader>yy  "+yy

" Paste from clipboard.
nnoremap <Leader>p "+p
nnoremap <Leader>P "+P
vnoremap <Leader>p "+p
vnoremap <Leader>P "+P
inoremap <Leader>p <ESC>"+P


" --------------- Miscellaneous Settings -------------------------------------

" Easier access to the <ESC>.
inoremap jk <ESC>

" Move to back and forward through buffer.
nnoremap <silent> <C-b> :bp<CR>
nnoremap <silent> <C-n> :bn<CR>

" FZF configuration.
nnoremap <Leader><Leader> :GitFiles<CR>

" CtrlP working directory is the nearest ancestor (directory with .git) or
" the current working directory.
let g:ctrlp_working_path_mode = 'ra'

" Ctrlp will ignore these files.
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc

" Set clang and c++ for syntastic.
let g:syntastic_cpp_compiler = 'clang++'
let g:syntastic_cpp_compiler_options = ' -std=c++11 -stdlib=libc++'

let g:syntastic_always_populate_loc_list = 1
nnoremap <Leader>mp :lprev<CR>
nnoremap <Leader>mn :lnext<CR>

" Open NERDTree with <Leader>t
nnoremap <Leader>t :NERDTreeToggle<CR>

" Close vim if NERDTree is the only window open.
augroup nerdtree
  autocmd! bufenter * if (winnr("$") == 1 &&
        \ exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
augroup END

" Removing YouCompleteMe preview window.
let g:ycm_add_preview_to_completeopt = 0
set completeopt-=preview

" Close preview window when done.
augroup youcompleteme
  autocmd!
  autocmd CompleteDone * pclose
augroup END

" Ultisnips configuration.
let g:UltiSnipsExpandTrigger = "<c-k>"
let g:UltiSnipsJumpForwardTrigger = "<c-j>"
let g:UltiSnipsJumpBackwardTrigger = "<c-k>"

" Open buffer list
nnoremap gb :ls<CR>:buffer<Space>


" --------------- EasyMotion Settings -----------------------------------------

" Disable default mappings
let g:EasyMotion_do_mapping = 0

" Turn on case insensitive feature.
let g:EasyMotion_smartcase = 1

" Jump anywhere with typing two characters.
nmap s <Plug>(easymotion-overwin-f2)

" Jump between words.
map <Leader>w <Plug>(easymotion-bd-w)


" --------------- Git Settings ------------------------------------------------

" Set 1 to start vim-gitgutter by default
let g:gitgutter_enabled = 0

" Enabled/Disabled'
map <Leader>g :GitGutterToggle<CR>

" Automatically wrap at 72 characters and spell check git commit messages
augroup git
  autocmd!
  autocmd FileType gitcommit setlocal textwidth=72
  autocmd FileType gitcommit setlocal spell
augroup END


" --------------- Markdown Settings -------------------------------------------

augroup markdown
  autocmd!
  autocmd BufEnter *.md       setlocal foldexpr=MarkdownFolding()
  autocmd BufRead,BufNewFile *.md setlocal wrap textwidth=80
augroup END

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


" --------------- Eclim Settings ---------------------------------------------

nnoremap <Leader>ei :JavaImport<CR>
nnoremap <Leader>ea :JavaImportOrganize<CR>
nnoremap <Leader>es :JavaSearchContext<CR>
nnoremap <Leader>er :JavaRename 

" Disable auto import of logger.
let g:EclimLoggingDisabled = 1


" --------------- Local vimrc ------------------------------------------------

if !empty(glob("$HOME/.vimrc.local"))
  source $HOME/.vimrc.local
endif
