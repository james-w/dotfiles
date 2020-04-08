filetype on            " enables filetype detection
filetype plugin on     " enables filetype specific plugins
filetype indent on     " enables filetype specific indent
syntax enable          " enable syntax highlighting

set wildmode=longest,list " when tab completing in a command line complete longest common string
                          " then list alternatives

" tabs are 4 spaces, and expand them
set softtabstop=4
set shiftwidth=4
set tabstop=4
set expandtab

" move the backup dir
set backupdir-=.
set backupdir+=. " put the current dir as the last option tried
set backupdir-=~/ " don't use the homedir
set backupdir^=~/.vim/backup/ " put ~/.vim/backup as the first option tried

" move the swapfile dir
set directory=./.vim-swap/ " use ./.vim-swap if it exists
set directory+=~/.vim/swap/ " use ~/.vim/swap otherwise
set directory+=/tmp/ " fallback to /tmp
set directory+=. " . as last resort

" turn on line numbers
set number
set relativenumber
