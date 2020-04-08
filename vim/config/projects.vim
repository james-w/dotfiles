function! FilesInProject()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
  else
    call jmacs#projects#fzf_files(dir, fzf#vim#with_preview({}))
  endif
endfunction

function! ProjectRecentFiles()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
  else
    let files = jmacs#projects#recent_files(dir)
    return fzf#run(fzf#wrap('recent', fzf#vim#with_preview({'source': files, 'options': '+s -m --prompt="Recent>"'})))
  endif
endfunction

call jmacs#bindings#register_call_binding('find file', 'call FilesInProject()', g:jmacs_project_group, 'f')
call jmacs#bindings#register_call_binding('recent files', 'call ProjectRecentFiles()', g:jmacs_project_group, 'r')

function! s:projects_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let dir = a:lines[0]
  call jmacs#projects#launch(dir)
endfunction

let s:bin_dir = expand('<sfile>:h').'/bin/'
let s:preview_cmd = 'bash '.escape(s:bin_dir . 'project_preview.sh', '\')

function! ListProjects()
  let projects = jmacs#projects#list_recent()
  return fzf#run(fzf#wrap('projects', {'source': projects, 'sink*': function('s:projects_sink'), 'options': '+s --tiebreak=index +m --prompt="Projects>" --preview ' . fzf#shellescape(s:preview_cmd . ' {}')}))
endfunction

call jmacs#bindings#register_call_binding('open recent project in layout', 'call ListProjects()', g:jmacs_project_group, 'l')

function! FindProject()
  let base = get(g:, 'jmacs_projects_base_dir', $HOME)
  let find = 'find ' . fzf#shellescape(base) . ' -type d'
  return fzf#run(fzf#wrap('dirs', {'source': find, 'sink*': function('s:projects_sink'), 'options': '+m --prompt="Dirs>" --preview ' . fzf#shellescape(s:preview_cmd . ' {}')}))
endfunction

call jmacs#bindings#register_call_binding('open project in layout', 'call FindProject()', g:jmacs_project_group, 'n')

" Double escape to get to normal mode in terminal
tnoremap <Esc><Esc> <C-\><C-n>

function! ProjectTerminal()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
    return
  endif
  let old_dir = getcwd()
  call chdir(dir)
  try
    call term_start($SHELL)
  finally
    call chdir(old_dir)
  endtry
endfunction

call jmacs#bindings#register_call_binding('open terminal in project root', 'call ProjectTerminal()', g:jmacs_project_group, '$')
