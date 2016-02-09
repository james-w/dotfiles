filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
filetype plugin indent on

set wildmode=longest,list

set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

colorscheme desert

call pathogen#infect()

let g:ctrlp_custom_ignore = '.*\.pyc'

set backupdir-=.
set backupdir+=.
set backupdir-=~/
set backupdir^=~/.vim/backup/

set directory=./.vim-swap//
set directory+=~/.vim/swap//
set directory+=~/tmp//
set directory+=.

syntax enable
set t_Co=256
set background=dark
let g:solarized_termcolors=256
colorscheme solarized

let g:syntastic_python_checkers = ['pyflakes', 'pep8', 'flake8', 'pylint']
let g:syntastic_always_populate_loc_list = 1

" airline
let g:airline#extensions#tabline#enabled = 1
let g:airline_powerline_fonts = 1
" have airline at start
set laststatus=2

:nnoremap <leader>s :update<CR>
:nnoremap <leader>f :Ag <C-r><C-w><CR>
:nnoremap <leader>c :cw<CR>
:nnoremap <leader>u :GundoToggle<CR>
:nnoremap <leader>t :TagbarToggle<CR>
:nnoremap <leader>l :ll<CR>

" for vim-gitgutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

