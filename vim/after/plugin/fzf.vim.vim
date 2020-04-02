call g:JmacsRegisterBinding('commands (have to press quickly)', ':Commands<CR>', ['<Space>'])
call g:JmacsRegisterBinding('keybindings', ':Maps<CR> ', ['?'])
call g:JmacsRegisterBinding('help', ':Helptags<CR> ', ['<F1>'])

call g:JmacsRegisterFileBinding('find file', ':Files<CR>', ['f'])
call g:JmacsRegisterFileBinding('find file', ':Files<CR>', ['F'])
call g:JmacsRegisterFileBinding('recent files', ':History<CR>', ['r'])
