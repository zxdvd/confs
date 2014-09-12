syntax on              " syntax highlighting
set nu                 " enable number

set cursorline         " highlight current line, column
set cursorcolumn
set hlsearch

set mouse=a            " enable mouse scroll

set	smartindent        " tab setting
set	tabstop=4
set	shiftwidth=4
set	expandtab

set ignorecase         " case insensitive
set smartcase

filetype plugin indent on

augroup autocmds
    " mutt setting
    autocmd BufRead /tmp/mutt-* set tw=80
    autocmd BufRead /tmp/mutt-* set spell spelllang=en_us
    " markdown setting
    autocmd BufRead,BufNewFile *.md set filetype=markdown spell spelllang=en_us tw=80
    autocmd FileType  make setlocal noexpandtab
    autocmd FileType python highlight Excess ctermbg=red ctermfg=white
    autocmd FileType python match Excess /\%80v.\+/
    autocmd FileType python set nowrap tw=80
augroup END

map ,e :e <C-R>=expand("%:h") . "/" <CR>

" write current file with sudo
cmap w!! w !sudo tee >/dev/null %
cabbr <expr> %% expand('%:p:h')

" disable expandtab for Makefile,makefile
