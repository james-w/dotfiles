" turn on solarized when it is loaded
set background=dark
set termguicolors

" Make strings italic
augroup ItalicStrings
    autocmd!
    autocmd ColorScheme * highlight String cterm=italic gui=italic
augroup END

" material.vim uses a background red for errors, but that doesn't work well
" with line highlighting, this triggers a workaround using
" https://stackoverflow.com/a/15019636
augroup MaterialFixes
    autocmd!
    autocmd ColorScheme material highlight Error term=reverse cterm=reverse ctermfg=9 ctermbg=15 gui=reverse guifg=#ff5370 guibg=#0f111a
augroup END

" Override the default ansi terminal colors to material
" so that :terminal looks good when termguicolors is used
let g:terminal_ansi_colors = [
    \ "#263238",
    \ "#F07178",
    \ "#C3E88D",
    \ "#FFCB6B",
    \ "#82AAFF",
    \ "#C792EA",
    \ "#89DDFF",
    \ "#EEFFFF",
    \ "#546E7A",
    \ "#F07178",
    \ "#C3E88D",
    \ "#FFCB6B",
    \ "#82AAFF",
    \ "#C792EA",
    \ "#89DDFF",
    \ "#FFFFFF",
    \ ]

let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'
colorscheme material
