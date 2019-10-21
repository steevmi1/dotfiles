syntax enable
filetype on
filetype plugin on
filetype indent on

set encoding=utf-8    " utf8 by default for new files
set nocompatible      " it's not 1985
set nobackup          " don't create ~backup files (persistent undo enabled)
set number            " show line numbers
set nowrap            " disable wrapping
set cursorline        " highlight current line
set ttyfast           " improve scrolling speed
set lazyredraw
set foldlevelstart=99 " unfold everything by default
set noerrorbells      " disable bell/flash
set history=1000      " command history length
set so=10             " horizontal scrollover
set backspace=2       " make backspace work normally
set tabpagemax=15     " max 15 tabs open
set laststatus=2      " always display statusbar
set previewheight=3   " maximum height for preview window
set showmatch         " highlight matching brace
set updatetime=750    " improve latency for plugins
set showcmd           " show commands as they're being input
set autoread          " automatically reload when changed externally
set hlsearch          " highlight all search matches
set incsearch         " start searching before hitting 'enter'
set ignorecase        " perform case-insensitive search
set smartcase         " ...unless search term has a capital letter
set hidden            " hide buffers instead of closing them
set wildmenu          " autocomplete for command menu
set modelines=1       " obey file modelines
set completeopt=menu,menuone,longest,preview
set timeoutlen=1000 ttimeoutlen=0

set smartindent       " autoindent
set expandtab         " replace hard tabs with spaces
set shiftwidth=2      " tab width = 2 spaces
set tabstop=2
set softtabstop=2

set pastetoggle=<F2>  " F2 to toggle paste mode
nnoremap <leader>q gqip
map <leader>= mzgg=G`z<CR>
noremap H :bp<CR>
noremap L :bn<CR>
nnoremap <leader><space> :noh<cr>
map B :.,$!fmt -75
map b !}fmt -75

if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')
Plug 'vim-scripts/Zenburn'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'airblade/vim-gitgutter'
" These two added from https://castel.dev/post/lecture-notes-1/
Plug 'lervag/vimtex'
Plug 'sirver/ultisnips'
call plug#end()

colors zenburn

let g:airline_symbols_ascii = 1
set noshowmode

" For vimtex
let g:tex_flavor='latex'
" let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'

" For UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
let g:UltiSnipsEditSplit = "tabdo"
"let g:UltiSnipsSnippetDirectories=[$HOME.'/.vim/UltiSnips']
