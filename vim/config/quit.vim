let s:QuitPrefix = 'q'

call g:JmacsRegisterGroup('quit', [s:QuitPrefix])

call g:JmacsRegisterBinding('save and quit', ':xa<CR>', [s:QuitPrefix, 's'])
call g:JmacsRegisterBinding('prompt and quit', ':conf qa<CR>', [s:QuitPrefix, 'q'])
call g:JmacsRegisterBinding('force quit', ':qa!<CR>', [s:QuitPrefix, 'Q'])
