" set a history dir so that searches can be repeated
let g:fzf_history_dir = '~/.local/share/fzf-history'

call g:JmacsRegisterBinding('commands (have to press quickly)', ':Commands<CR>', ['<Space>'])
call g:JmacsRegisterBinding('keybindings', ':Maps<CR> ', ['?'])
call g:JmacsRegisterBinding('help', ':Helptags<CR> ', ['<F1>'])

call g:JmacsRegisterFileBinding('find file', ':Files<CR>', ['f'])
call g:JmacsRegisterFileBinding('find file', ':Files<CR>', ['F'])
call g:JmacsRegisterFileBinding('recent files', ':History<CR>', ['r'])

call g:JmacsRegisterSearchBinding('swoop', ':BLines<CR>', ['s'])

function! AgDirCurrentFile()
  let dir = expand('%:p:h')
  call fzf#vim#ag('', {'dir': dir})
endfunction

call g:JmacsRegisterSearchCallBinding('dir of current file', 'call AgDirCurrentFile()', ['a', 'd'])

function! FilesInProject()
  let dir = FindRootDirectory()
  call fzf#vim#files('', fzf#vim#with_preview({'dir': dir}))
endfunction

call g:JmacsRegisterProjectCallBinding('find file', 'call FilesInProject()', ['f'])

call g:JmacsRegisterBinding('list buffers', ':Buffers<CR> ', ['b', 'b'])
