" enable number
set nu
" highlight current line, column
set cursorline
set cursorcolumn
set hlsearch

" tab setting
set	smartindent
set	tabstop=4
set	shiftwidth=4
set	expandtab

" case insensitive
set ignorecase
set smartcase

" mutt setting
" to limit the width of text to 72 characters
autocmd BufRead /tmp/mutt-* set tw=72
autocmd BufRead /tmp/mutt-* set spell spelllang=en_us

map ,e :e <C-R>=expand("%:h") . "/" <CR>

" write current file with sudo
cmap w!! w !sudo tee >/dev/null %
cabbr <expr> %% expand('%:p:h')

" disable expandtab for Makefile,makefile
autocmd FileType  make setlocal noexpandtab
