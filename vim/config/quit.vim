let s:quit_group = jmacs#bindings#register_group('quit', g:jmacs_top_group, 'q')

call jmacs#bindings#register_binding('save and quit', ':xa<CR>', s:quit_group, 's')
call jmacs#bindings#register_binding('prompt and quit', ':conf qa<CR>', s:quit_group, 'q')
call jmacs#bindings#register_binding('force quit', ':qa!<CR>', s:quit_group, 'Q')
