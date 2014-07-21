" enable number
set nu
" highlight current line, column
set cursorline
set cursorcolumn
set hlsearch

" enable mouse scroll
set mouse=a

" tab setting
set	smartindent
set	tabstop=4
set	shiftwidth=4
set	expandtab

" case insensitive
set ignorecase
set smartcase

" mutt setting
" to limit the width of text to 80 characters
autocmd BufRead /tmp/mutt-* set tw=80
autocmd BufRead /tmp/mutt-* set spell spelllang=en_us
" markdown setting
autocmd BufRead,BufNewFile *.md set filetype=markdown spell spelllang=en_us tw=80

map ,e :e <C-R>=expand("%:h") . "/" <CR>

" write current file with sudo
cmap w!! w !sudo tee >/dev/null %
cabbr <expr> %% expand('%:p:h')

" disable expandtab for Makefile,makefile
autocmd FileType  make setlocal noexpandtab
