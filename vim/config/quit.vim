let s:QuitPrefix = 'q'

call jmacs#bindings#register_group('quit', [s:QuitPrefix])

call jmacs#bindings#register_binding('save and quit', ':xa<CR>', [s:QuitPrefix, 's'])
call jmacs#bindings#register_binding('prompt and quit', ':conf qa<CR>', [s:QuitPrefix, 'q'])
call jmacs#bindings#register_binding('force quit', ':qa!<CR>', [s:QuitPrefix, 'Q'])
