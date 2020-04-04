function! FilesInProject()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    echoerr 'Not in a project'
  else
    call fzf#vim#files(dir, fzf#vim#with_preview({}))
  endif
endfunction

call jmacs#bindings#register_call_binding('find file', 'call FilesInProject()', g:jmacs_project_group, 'f')

function! s:projects_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let dir = a:lines[0]
  call jmacs#projects#launch(dir)
endfunction

function! ListProjects()
  let projects = jmacs#projects#list_recent()
  return fzf#run(fzf#wrap('projects', {'source': projects, 'sink*': function('s:projects_sink'), 'options': '+s --tiebreak=index +m --prompt="Projects>"'}))
endfunction

call jmacs#bindings#register_call_binding('open recent project in layout', 'call ListProjects()', g:jmacs_project_group, 'l')
