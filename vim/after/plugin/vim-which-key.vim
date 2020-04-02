set timeoutlen=500

call which_key#register(mapleader, "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey mapleader<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual mapleader<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  localleader<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  localleader<CR>

" hide statusbar
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 showmode ruler
