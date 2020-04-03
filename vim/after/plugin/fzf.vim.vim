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
  if empty(dir)
    echoerr 'Not in a project'
  else
    call fzf#vim#files('', fzf#vim#with_preview({'dir': dir}))
  endif
endfunction

call g:JmacsRegisterProjectCallBinding('find file', 'call FilesInProject()', ['f'])

call g:JmacsRegisterBinding('list buffers', ':Buffers<CR> ', ['b', 'b'])

function! s:get_projects()
  let dirs = []
  let dir_map = {}
  for path in v:oldfiles
    let dir = fnamemodify(path, ':p:h')
    if !has_key(dir_map, dir)
      call add(dirs, dir)
      let dir_map[dir] = 1
    endif
  endfor

  let projects = []
  let project_map = {}
  for dir in dirs
    let project = SearchForRootDirectory(dir)
    if !empty(project)
      if !has_key(project_map, project)
        call add(projects, project)
        let project_map[project] = 1
      endif
    endif
  endfor
  return projects
endfunction

function! s:new_project_sink(lines)
  if len(a:lines) < 2
    return
  endif
  " If there are no listed buffers then don't open a new tab
  if &buflisted > 0
    execute 'tabedit ' . a:lines[1]
  else
    execute 'edit ' . a:lines[1]
  endif
endfunction

function! s:projects_sink(lines)
  call fzf#vim#files(a:lines[0], {'sink*': function('s:new_project_sink'), 'options': '--expect=ctrl-t'})
endfunction

function! ListProjects()
  let projects = s:get_projects()
  return fzf#run(fzf#wrap('projects', {'source': projects, 'sink*': function('s:projects_sink'), 'options': '+s --tiebreak=index +m --prompt="Projects>"'}))
endfunction

call g:JmacsRegisterProjectCallBinding('list', 'call ListProjects()', ['l'])
