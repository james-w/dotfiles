" turn on solarized when it is loaded
set background=dark
set termguicolors

" Make strings italic
augroup ItalicStrings
    autocmd!
    autocmd ColorScheme * highlight String cterm=italic gui=italic
augroup END

function! MaterialFixes() abort
    " material.vim uses a background red for errors, but that doesn't work well
    " with line highlighting, this triggers a workaround using
    " https://stackoverflow.com/a/15019636
    highlight Error term=reverse cterm=reverse ctermfg=9 ctermbg=15 gui=reverse guifg=#ff5370 guibg=#0f111a
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
endfunction

augroup MaterialFixes
    autocmd!
    autocmd ColorScheme material call MaterialFixes()
augroup END

let g:material_terminal_italics = 1
let g:material_theme_style = 'ocean'

let g:gruvbox_italic = 1

augroup GruvboxMaterialAirline
    autocmd!
    autocmd ColorScheme gruvbox-material execute 'AirlineTheme gruvbox_material'
augroup END

let g:jellybeans_use_term_italics = 1

let g:monokai_term_italic = 1
let g:monokai_gui_italic = 1

let g:one_allow_italics = 1

colorscheme material
