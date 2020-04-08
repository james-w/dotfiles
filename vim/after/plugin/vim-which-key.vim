set timeoutlen=500

call which_key#register(mapleader, "g:which_key_map")

nnoremap <silent> <leader>      :<c-u>WhichKey mapleader<CR>
vnoremap <silent> <leader>      :<c-u>WhichKeyVisual mapleader<CR>
nnoremap <silent> <localleader> :<c-u>WhichKey  localleader<CR>
vnoremap <silent> <localleader> :<c-u>WhichKeyVisual  localleader<CR>
