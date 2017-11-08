" Leader Keys
let mapleader="\\"
let maplocalleader=","

" Configure plugin loading.
" This `filetype` dance is to correctly handle various
" environments and their defaults for file type detection
" and a weird OS X bug which causes a non-zero exit code.
filetype on
filetype off
call pathogen#infect()
call pathogen#helptags()
filetype plugin indent on
syntax on

" Indentdation
set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab
set smartindent

" Search
set hlsearch
set incsearch
set ignorecase
set smartcase
map <leader>a :Ag 
map <leader>f :Ag 
map <leader>/ :let @/ = ""<cr>
runtime macros/matchit.vim

" Shed light on hidden things
set list
"set listchars=tab:»›,trail:•,nbsp:•,precedes:↤,extends:↦
set listchars=tab:»›,trail:•,nbsp:•,precedes:<,extends:>
set wrap
set linebreak
"set showbreak=↳
set showbreak=\
set nofoldenable

" Completion
inoremap <Nul> <C-x><C-o>
set completeopt+=longest

" Smart file opening => COMMENTED OUT
"nnoremap <leader>t :Unite -no-split -start-insert file_rec/async:.<cr>
"call unite#custom_source('file_rec,file_rec/async,file_mru,file,buffer,grep',
"      \ 'ignore_pattern', join([
"      \ '\.git/',
"      \ 'tmp/',
"      \ 'log/',
"      \ '*.log',
"      \ '.sass-cache',
"      \ 'node_modules/',
"      \ 'bower_components/',
"      \ 'dist/',
"      \ '.pyc',
"      \ ], '\|'))
set wildignore+=*.pyc,*.o,*.class,*.sassc
set wildignore+=.png,*.jpg,*.gif,*bmp
set wildignore+=*.min.css,*.min.js
set wildignore+=node_modules/**

" Force myself to learn to use hjkl for navigation
"map <down> <nop>
"map <left> <nop>
"map <right> <nop>
"map <up> <nop>

" Easier window navigation
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Convienence mappings
nnoremap <Space> :
nmap <leader>q :q<cr>
nmap <leader>w :w<cr>
nmap <leader>m :make<cr>
nmap <leader>n :NERDTreeToggle<cr>

" Scrolling
set ruler
set guioptions-=l
set guioptions-=r
set guioptions-=L
set guioptions-=R
set guioptions-=T
set scrolloff=3

" Other
set visualbell t_vb=
set nocompatible
set modelines=1
"set autoreload

" NERD Tree configuration
let NERDTreeIgnore=['.pyc$', '.pyo$', '\~$']

" Colors
" set t_Co=256

" Insert blank lines without enterting insert mode
" disabled because these break pressing enter in ack
"nmap <S-Enter> O<Esc>
"nmap <CR> o<Esc>

" Remap s/S to surround operations
" :help text-objects
nmap s ys
nmap S yS

" Sets the number of columns to support n windows of a given width.
function! SplitNVertical(nSplits, width)
    let &columns = (a:width + 1) * a:nSplits - 1
    execute "normal \<C-w>="
endfunction
nmap <leader>1 :call SplitNVertical(1, 79)<cr>
nmap <leader>2 :call SplitNVertical(2, 79)<cr>
nmap <leader>3 :call SplitNVertical(3, 79)<cr>

" Toggles colorcolumn
function! ToggleColorColumn()
  if &colorcolumn > 0
    set colorcolumn=
  else
    set colorcolumn=80
  endif
endfunction
nmap <leader>0 :call ToggleColorColumn()<cr>

" Undo stuff
nnoremap <leader>u :GundoToggle<CR>

" Undo persistance
if version >= 703
  set undodir=~/.vim/undodir
  set undofile
  set undolevels=1000
  set undoreload=10000
endif

" Treat jst files as html.erb files.
au! BufNewFile,BufRead *.jst setfiletype haml

" Configure Gist support to copy to clipboard
let g:gist_clip_command = 'pbcopy'
let g:gist_post_private = 1

" Clojure preferences
let g:clojure_fuzzy_indent = 1

" Stablize syntax highlighting for larger files
"autocmd BufEnter * :syntax sync fromstart
autocmd BufEnter * :syntax sync minlines=200

" Jumping to Files
"TODO: Do this in autoload files by file-type.
set path+=src
set suffixesadd=.js,.jsx

" Go
let g:go_fmt_command = "goimports"
