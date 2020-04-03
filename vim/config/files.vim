call jmacs#bindings#register_group('files', [g:JmacsFilePrefix])

call jmacs#bindings#register_file_binding('delete current file', ':!rm %<CR>', ['D'])
call jmacs#bindings#register_file_binding('view directory listing', ':Ex<CR>', ['j'])
call jmacs#bindings#register_file_binding('save current file', ':update<CR>', ['s'])
call jmacs#bindings#register_file_binding('save all files', ':wall<CR>', ['S'])

call jmacs#bindings#register_group('jmacs', [g:JmacsFilePrefix, 'e'])

call jmacs#bindings#register_file_binding('edit vimrc', ':edit $MYVIMRC<CR>', ['e', 'd'])
call jmacs#bindings#register_file_binding('reload vimrc', ':source $MYVIMRC<CR>', ['e', 'R'])
