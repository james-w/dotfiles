" set a history dir so that searches can be repeated
let g:fzf_history_dir = '~/.local/share/fzf-history'

let g:fzf_layout = { 'window': { 'width': 1, 'height': 0.4, 'yoffset': 1, 'border': 'horizontal' } }

" Fix Esc hanlding in fzf buffer
au FileType fzf silent! tunmap <Esc>
