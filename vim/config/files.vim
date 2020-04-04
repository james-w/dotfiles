call jmacs#bindings#register_binding('delete current file', ':!rm %<CR>', g:jmacs_file_group, 'D')
call jmacs#bindings#register_binding('view directory listing', ':Ex<CR>', g:jmacs_file_group, 'j')
call jmacs#bindings#register_binding('save current file', ':update<CR>', g:jmacs_file_group, 's')
call jmacs#bindings#register_binding('save all files', ':wall<CR>', g:jmacs_file_group, 'S')

let s:jmacs_group = jmacs#bindings#register_group('jmacs', g:jmacs_file_group, 'e')

call jmacs#bindings#register_binding('edit vimrc', ':edit $MYVIMRC<CR>', s:jmacs_group, 'd')
call jmacs#bindings#register_binding('reload vimrc', ':source $MYVIMRC<CR>', s:jmacs_group, 'R')
