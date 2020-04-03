" set a history dir so that searches can be repeated
let g:fzf_history_dir = '~/.local/share/fzf-history'

call jmacs#bindings#register_binding('commands (have to press quickly)', ':Commands<CR>', ['<Space>'])
call jmacs#bindings#register_binding('keybindings', ':Maps<CR> ', ['?'])
call jmacs#bindings#register_binding('help', ':Helptags<CR> ', ['<F1>'])

call jmacs#bindings#register_file_binding('find file', ':Files<CR>', ['f'])
call jmacs#bindings#register_file_binding('find file', ':Files<CR>', ['F'])
call jmacs#bindings#register_file_binding('recent files', ':History<CR>', ['r'])

call jmacs#bindings#register_search_binding('swoop', ':BLines<CR>', ['s'])

function! AgDirCurrentFile()
  let dir = expand('%:p:h')
  call fzf#vim#ag('', {'dir': dir})
endfunction

call jmacs#bindings#register_search_call_binding('dir of current file', 'call AgDirCurrentFile()', ['a', 'd'])

function! FilesInProject()
  let dir = FindRootDirectory()
  if empty(dir)
    echoerr 'Not in a project'
  else
    call fzf#vim#files('', fzf#vim#with_preview({'dir': dir}))
  endif
endfunction

call jmacs#bindings#register_project_call_binding('find file', 'call FilesInProject()', ['f'])

call jmacs#bindings#register_binding('list buffers', ':Buffers<CR> ', ['b', 'b'])

function! s:projects_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let dir = a:lines[0]
  call g:JmacsLaunchProject(dir)
endfunction

function! ListProjects()
  let projects = g:JmacsGetProjects()
  return fzf#run(fzf#wrap('projects', {'source': projects, 'sink*': function('s:projects_sink'), 'options': '+s --tiebreak=index +m --prompt="Projects>"'}))
endfunction

call jmacs#bindings#register_project_call_binding('open recent project in layout', 'call ListProjects()', ['l'])
