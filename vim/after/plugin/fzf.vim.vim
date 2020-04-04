" set a history dir so that searches can be repeated
let g:fzf_history_dir = '~/.local/share/fzf-history'

call jmacs#bindings#register_binding('commands (have to press quickly)', ':Commands<CR>', g:jmacs_top_group, '<Space>')
call jmacs#bindings#register_binding('keybindings', ':Maps<CR> ', g:jmacs_top_group, '?')
call jmacs#bindings#register_binding('help', ':Helptags<CR> ', g:jmacs_top_group, '<F1>')

call jmacs#bindings#register_binding('find file', ':Files<CR>', g:jmacs_file_group, 'f')
call jmacs#bindings#register_binding('find file', ':Files<CR>', g:jmacs_file_group, 'F')
call jmacs#bindings#register_binding('recent files', ':History<CR>', g:jmacs_file_group, 'r')

call jmacs#bindings#register_binding('swoop', ':BLines<CR>', g:jmacs_search_group, 's')

function! AgDirCurrentFile()
  let dir = expand('%:p:h')
  call fzf#vim#ag('', {'dir': dir})
endfunction

let s:ag_group = jmacs#bindings#register_group('ag', g:jmacs_search_group, 'a')
call jmacs#bindings#register_call_binding('dir of current file', 'call AgDirCurrentFile()', s:ag_group, 'd')

function! FilesInProject()
  let dir = FindRootDirectory()
  if empty(dir)
    echoerr 'Not in a project'
  else
    call fzf#vim#files('', fzf#vim#with_preview({'dir': dir}))
  endif
endfunction

call jmacs#bindings#register_call_binding('find file', 'call FilesInProject()', g:jmacs_project_group, 'f')

call jmacs#bindings#register_binding('list buffers', ':Buffers<CR> ', g:jmacs_buffers_group, 'b')

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

call jmacs#bindings#register_call_binding('open recent project in layout', 'call ListProjects()', g:jmacs_project_group, 'l')
