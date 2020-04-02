call g:JmacsRegisterGroup('files', [g:JmacsFilePrefix])

call g:JmacsRegisterFileBinding('delete current file', ':!rm %<CR>', ['D'])
call g:JmacsRegisterFileBinding('view directory listing', ':Ex<CR>', ['j'])
call g:JmacsRegisterFileBinding('save current file', ':update<CR>', ['s'])

call g:JmacsRegisterGroup('jmacs', [g:JmacsFilePrefix, 'e'])

call g:JmacsRegisterFileBinding('edit vimrc', ':edit $MYVIMRC<CR>', ['e', 'd'])
call g:JmacsRegisterFileBinding('reload vimrc', ':source $MYVIMRC<CR>', ['e', 'R'])
