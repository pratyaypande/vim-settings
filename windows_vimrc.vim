"   Author: Pratyay Pande
"   Date Created: February 28, 2020
"   Note: Please execute update.py for updating the file
"
set number
syntax on
set backspace=2
set background=dark
set laststatus=2
" additional settings for gvim - if used in windows
if has("gui_running")
    " GUI is running or is about to start.
    " Maximize gvim window (for an alternative on Windows, see simalt).
    set guifont=Lucida_Console h10 " change the : to a space when on vim-gtk
    set guioptions -=T
    set guioptions -=m
    set lines=45 columns=140
    " set guicursor+=n-v-c:blinkon0
    " set guicursor+=i:ver100-iCursor
"else
  " This is console Vim.
"  if exists("+lines")
"    set lines=50
"  endif
"  if exists("+columns")
"    set columns=100
"  endif
endif
set relativenumber
set incsearch
set linespace=0
set ignorecase
set smartcase
set nohlsearch
set tabstop=4
set softtabstop=0
set shiftwidth=4
set expandtab
set title
set nobackup
set noswapfile
set sidescroll=0
set splitbelow
set mouse=a
set autoindent
set smartindent
syntax enable
set t_Co=256
set clipboard=unnamed
syntax on
set completeopt-=preview
colorscheme gruvbox
"set background=light
set nocompatible
filetype off
set shellslash
set rtp+=~/.vim/bundle/Vundle.vim
"linux: 
call vundle#begin('~/.vim/bundle')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'jiangmiao/auto-pairs'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'enricobacis/vim-airline-clock'
"Plugin 'ycm-core/YouCompleteMe'
call vundle#end()            " required
filetype plugin indent on    " required
" YCM settings: will work once YCM is installed
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
nnoremap <silent> <C-b> :Lexplore<CR>
imap <C-y> <Esc> :YcmCompleter GoTo <CR>i
nnoremap <space> <Nop>
map <space> <leader>
imap <C-d> <Esc>dd<Esc>i
" Multiple tabs:
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>
nnoremap <leader>OC gt
nnoremap <leader>OD gT
"github shortcuts - vim-fugitive
nmap <leader>gh :diffget //3<CR>
nmap <leader>gu :diffget //2<CR>
nmap <leader>gs :G<CR>
nmap <leader>gc :Git commit<CR>
nmap <leader>gh :Git push<CR>:q<CR>
nmap <leader>gl :Git pull<CR>
"terminal mappings
map <leader>tv <Esc>:below vertical terminal<CR>
map <leader>th <Esc>:terminal<CR>
"function for comments (test)
func! Comment()
    if &filetype == 'python'
        r "#"
    elseif (&filetype == 'cpp') || (&filetype == 'c') || (&filetype == 'js')
        r "//"
    endif
endfunc
imap <F7> <Home><Esc>:call Comment()<CR>i
"custom functions and 
imap <C-a> <Esc><Home>v<End>y<Esc>i
map <F5> :call CompileRun()<CR>
imap <F5> <Esc>:call CompileRun()<CR>
vmap <F5> <Esc>:call CompileRun()<CR>
imap <F6> <Esc>:call FastRun()<CR>
map <F6> <Esc>:call FastRun()<CR>
vmap <F6> <Esc>:call FastRun()<CR>
func! FastRun()
exec "w"
if &filetype == 'cpp'
    exec "!g++ -std=c++17 -Wshadow -Wall % -O2 -Wno-unused-result && echo 'Compiled... Ready for input...' && a.exe && del a.exe"
    
endif
endfunc

func! CompileRun()
exec "w"
if &filetype == 'c'
    exec "!gcc -pipe -O2 -std=c11 % -lm && time ./a.out && rm a.out"
elseif &filetype == 'cpp'
    exec "!g++ -std=c++17 -Wshadow -Wall % -D_GLIBCXX_DEBUG && echo 'Compiled... Ready for input...' && a.exe && del a.exe"
    " flags which somehow dont work in windows: -fsanitize=address -fsanitize=undefined -D_GLIBCXX_DEBUG"
    " Ubuntu 20.04: a.out and Windows 10: a.exe
elseif &filetype == 'java'
    exec "!javac % && time java %"
elseif &filetype == 'sh'
    exec "!bash %"
elseif &filetype == 'python'
    exec "!python %"
elseif &filetype == 'html'
    exec "!google-chrome % &"
elseif &filetype == 'go'
    exec "!go build %< && time go run %"
elseif &filetype == 'md'
    exec "!~/.vim/markdown.pl %:p > %.html &:p && !google-chrome %.html &:p"
elseif &filetype == 'matlab'
    exec "!octave %:p"
elseif &filetype == 'php'
    exec "!php %"
endif
endfunc
"custom code fillers for stuff
imap <F2>m <Esc>:call CfMain()<CR>:1<CR>dd:62<CR>i<Tab><Tab>
imap <F2>cm <Esc>:call Codeforces()<CR><Esc>i
imap <F2>bh <Esc>:call BinaryHeap()<CR><Esc>i
imap <F2>ph <Esc>:call PairHashMap()<CR><Esc>i
imap <F2>srt <Esc>:call Sorting()<CR><Esc>i
imap <F2>gph <Esc>:call Graph()<CR><Esc>i

func! SmallMain()
    if  &filetype == 'cpp'
        r~/.vim/codelines/cpp_small_main.cpp
    endif
endfunction


func! Sorting()
    if  &filetype == 'cpp'
        echo "Helloworld"
"        r~/.vim/codelines/cpp_sorting.cpp
    endif
endfunction

func! Graph()
    if  &filetype == 'cpp'
        r~/.vim/codelines/cpp_graph.cpp
    endif
endfunction


func! PairHashMap()
    if &filetype == 'cpp'
        r~/.vim/codelines/cpp_pair_hashmap.cpp
    endif
endfunction

func! BinaryHeap()
if &filetype == 'cpp'
    r~/.vim/codelines/cpp_heap_struct.cpp
endif
endfunction

func! Codeforces()
if &filetype == 'cpp'
    r~/.vim/codelines/cf_loop_t.cpp
endif
endfunction

func! CfMain()
if &filetype == 'cpp'
    r~/.vim/codelines/cpp_small_main.cpp
elseif &filetype == 'java'
    r~/.vim/codelines/java_main_and_beginning.java
elseif &filetype == 'python'
    r~/.vim/codelines/python_beginning_main.py
elseif &filetype == 'html'
    r~/.vim/codelines/html_vscode_doc.txt
endif
endfunction
highlight Pmenu ctermbg=gray gui=bold
highlight LineNr ctermfg=white gui=bold
highlight clear LineNr
syntax enable
let vim_markdown_preview_github=1
let g:airline_theme='angr'
"netrw settings:
let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 20
"airline clock settings
let g:airline#extensions#clock#auto = 0
function! AirlineInit()
    let g:airline_section_z = airline#section#create(['clock', g:airline_symbols.space, g:airline_section_z])
endfunction
autocmd User AirlineAfterInit call AirlineInit()
