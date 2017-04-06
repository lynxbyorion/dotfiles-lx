" General
" set shell=/bin/bash
filetype plugin indent on

set autoread
set nocp


let mapleader = "\\"
let g:mapleader = "\\"

" Plugins
call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
"Plug 'Valloric/YouCompleteMe',
"Plug 'scrooloose/syntastic'
Plug 'ctrlpvim/ctrlp.vim'
"Plug 'altercation/vim-colors-solarized'
Plug 'iCyMind/NeoSolarized'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'majutsushi/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'ap/vim-css-color'
Plug 'suan/vim-instant-markdown'
Plug 'tpope/vim-fugitive'
Plug 'junegunn/goyo.vim'
Plug 'jmcantrell/vim-virtualenv'
Plug 'Rykka/riv.vim'
Plug 'fatih/vim-go'
Plug 'Shougo/neocomplete.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'ruscmd'
Plug 'lervag/vimtex'
Plug 'junegunn/vim-easy-align'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'

call plug#end()



" Interface
set list listchars=tab:▷⋅,trail:⋅,nbsp:⋅
set cursorline
set colorcolumn=80

set scrolloff=5
set ruler
set number
set showcmd

" Turn on the WiLd menu
set wildmenu
" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"set foldcolumn=5
set lazyredraw

set magic

set showmatch
set cmdheight=2
set mat=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500


" Search
set ignorecase
set hlsearch
set incsearch

colorscheme NeoSolarized

set backspace=2

" => Spell checking
"""""""""""""""""""
set spelllang=ru,en
map <leader>ss :setlocal spell!<cr>



" Text and indent
set expandtab
set smarttab
set shiftwidth=4
set tabstop=4
set autoindent
set smartindent
set wrap


" Files, backups and undo
set nobackup
set nowb
set noswapfile


" => Visual mode related
""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
" Super useful! From an idea by Michael Naumann
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"Moving around, windows and buffers
map j gj
map k gk
map <silent> <leader><cr> :noh<cr>


" Python section
au FileType py set autoindent
au FileType py set smartindent
au FileType py set textwidth=79

" yaml section
au FileType yaml set tabstop=2 shiftwidth=2

" Mutt section
au BufRead ~/.mutt/temp/mutt-* set tw=72
au BufRead ~/.mutt/temp/mutt-* set spell

" Text type section
au FileType markdown,rst,txt,tex set textwidth=79
au FileType markdown,rst,txt,tex set spell

" au FileType go highlight SpecialKey cterm=None ctermbg=None ctermfg=252

" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Helper functions
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! CmdLine(str)
    exe "menu Foo.Bar :" . a:str
    emenu Foo.Bar
    unmenu Foo
endfunction

function! VisualSelection(direction, extra_filter) range
    let l:saved_reg = @"
    execute "normal! vgvy"

    let l:pattern = escape(@", '\\/.*$^~[]')
    let l:pattern = substitute(l:pattern, "\n$", "", "")

    if a:direction == 'b'
        execute "normal ?" . l:pattern . "^M"
    elseif a:direction == 'gv'
        call CmdLine("Ack \"" . l:pattern . "\" " )
    elseif a:direction == 'replace'
        call CmdLine("%s" . '/'. l:pattern . '/')
    elseif a:direction == 'f'
        execute "normal /" . l:pattern . "^M"
    endif

    let @/ = l:pattern
    let @" = l:saved_reg
endfunction


" Plugins
" Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
" for python
let g:syntastic_python_checkers = ['flake8']

" Lightline
" let g:lightline = {'colorscheme': 'solarized'}


set fileencodings=utf-8,cp1251

if !exists('g:neocomplete#sources#omni#input_patterns')
    let g:neocomplete#sources#omni#input_patterns = {}
endif
let g:neocomplete#sources#omni#input_patterns.tex =
            \ '\v\\%('
            \ . '\a*cite\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|\a*ref%(\s*\{[^}]*|range\s*\{[^,}]*%(}\{)?)'
            \ . '|hyperref\s*\[[^]]*'
            \ . '|includegraphics\*?%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|%(include%(only)?|input)\s*\{[^}]*'
            \ . '|\a*(gls|Gls|GLS)(pl)?\a*%(\s*\[[^]]*\]){0,2}\s*\{[^}]*'
            \ . '|includepdf%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . '|includestandalone%(\s*\[[^]]*\])?\s*\{[^}]*'
            \ . ')'
