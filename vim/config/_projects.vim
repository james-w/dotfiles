function! g:JmacsGetProjects()
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
    let project = g:JmacsGetProjectFor(dir)
    if !empty(project)
      if !has_key(project_map, project)
        call add(projects, project)
        let project_map[project] = 1
      endif
    endif
  endfor
  return projects
endfunction

function! g:JmacsGetProjectFor(path)
  return SearchForRootDirectory(a:path)
endfunction

function! s:new_project_sink(name, lines)
  if len(a:lines) < 2
    return
  endif
  " If there are no listed buffers then don't open a new tab
  if &buflisted > 0
    execute 'tabedit ' . a:lines[1]
  else
    execute 'edit ' . a:lines[1]
  endif
  execute 'TabooRename ' . a:name
endfunction

function! g:JmacsLaunchProject(dir)
  let name = fnamemodify(a:dir, ':t')
  let opts = {}
  " limit extra options to ctrl-t as we are going to force a new tab rather
  " than a split
  let opts.options = '--expect=ctrl-t'
  function! s:_p_sink(lines) closure
    call s:new_project_sink(name, a:lines)
  endfunction
  let opts['sink*'] = function('s:_p_sink')
  call fzf#vim#files(a:dir, opts)
endfunction
