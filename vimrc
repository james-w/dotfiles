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

let mapleader="\<Space>"

:nnoremap <leader>fs :update<CR>
:nnoremap <leader>qs :xa<CR>
:nnoremap <leader>qq :conf qa<CR>
:nnoremap <leader>qQ :qa!<CR>

" ack.vim, using ag
let g:ackprg = 'ag --vimgrep --smart-case'

function! AckPrompt()
  let cword = expand("<cword>")
  let dir = expand('%:p:h')
  let curline = getline('.')
  call inputsave()
  let term = input('Search for: ', cword)
  call inputrestore()
  call setline('.', curline . ' ' . term)
  execute ':Ack' term dir
endfunction

:nnoremap <leader>sad :call AckPrompt()<CR>
:nnoremap <leader>sl :copen<CR>

" undotree
:nnoremap <leader>au :UndotreeToggle<CR>

" tagbar
:nnoremap <leader>at :TagbarToggle<CR>

" for vim-gitgutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

" for vim-which-key
set timeoutlen=500

let g:which_key_map = {}

let g:which_key_map.a = { 'name': '+applications' }
let g:which_key_map.a.u = 'undotree'
let g:which_key_map.a.t = 'tagbar'

let g:which_key_map.f = { 'name': '+files' }
let g:which_key_map.f.s = 'save current file'

let g:which_key_map.q = { 'name': '+quit' }
let g:which_key_map.q.s = 'save and quit'
let g:which_key_map.q.q = 'prompt and quit'
let g:which_key_map.q.Q = 'force quit'

let g:which_key_map.s = { 'name': '+search' }
let g:which_key_map.s.a = { 'name' : '+ag' }
let g:which_key_map.s.a.d = 'search dir of current file'
let g:which_key_map.s.l = 'show previous results'

call which_key#register('<Space>', "g:which_key_map")
nnoremap <silent> <leader>      :<c-u>WhichKey '<Space>'<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual '<Space>'<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  ','<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  ','<CR>

" hide statusbar
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
