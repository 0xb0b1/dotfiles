
set shell=/bin/tcsh

syntax on
filetype plugin indent on     " required

" specific settings
set nocompatible               " be iMproved
set cursorline
set title
set noautoindent
set ruler
set shortmess=aoOTI
set showmode
set splitbelow
set splitright
set showcmd
set showmatch
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set cinoptions=(0,m1,:1
set formatoptions=tcqr2
set laststatus=2
set nomodeline
set clipboard=unnamed
set showtabline=1
set smartcase
set smarttab
set sidescroll=5
set scrolloff=4
set hlsearch
set history=10000
set ttyfast
set hidden
set number
set backspace=indent,eol,start
set ttimeoutlen=100
set foldlevelstart=0

" Better completion
set complete=.,w,b,u,t
set completeopt=longest,menuone,preview,menu

" Leader
let mapleader = ","
let maplocalleader = "\\"

augroup line_return
    au!
    au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g`"zvzz' |
        \ endif
augroup END

colorscheme plain
set background=dark
set statusline=
set statusline+=%7*\[%n]                                  "buffernr
set statusline+=%1*\ %<%F\                                "File+path
set statusline+=%2*\ %y\                                  "FileType
set statusline+=%3*\ %{''.(&fenc!=''?&fenc:&enc).''}      "Encoding
set statusline+=%3*\ %{(&bomb?\",BOM\":\"\")}\            "Encoding2
set statusline+=%4*\ %{&ff}\                              "FileFormat (dos/unix..)
set statusline+=%5*\ %{&spelllang}\                       "Spellanguage
set statusline+=%8*\ %=\ row:%l/%L\ (%03p%%)\             "Rownumber/total (%)
set statusline+=%9*\ col:%03c\                            "Colnr
set statusline+=%0*\ \ %m%r%w\ %P\ \                      "Modified? Readonly?  Top/bot.
let mapleader = ","

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 0
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

noremap <C-n> :NERDTreeToggle<CR>

nnoremap <C-j> :write<CR> :bnext<CR>
nnoremap <C-k> :write<CR> :bprevious<CR>
nnoremap <F9> :TagbarToggle<CR>
nnoremap <leader>ev :vsplit ~/.vimrc<CR>

noremap j gj
noremap k gk

nnoremap n nzzzv
nnoremap N Nzzzv

noremap <leader>v <C-w>v
