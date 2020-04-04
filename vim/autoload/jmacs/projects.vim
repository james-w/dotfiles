let s:skiplist = [
      \ 'runtime/doc/.*\.txt',
      \ 'bundle/.*/doc/.*\.txt',
      \ 'plugged/.*/doc/.*\.txt',
      \ '/.git/',
      \ 'fugitiveblame$',
      \ '^fugitive://$',
      \ escape(fnamemodify(resolve($VIMRUNTIME), ':p'), '\') .'doc/.*\.txt',
      \ ]

function! s:is_in_skiplist(arg) abort
  for regexp in s:skiplist
    if a:arg =~# regexp
      return 1
    endif
  endfor
endfunction

function! jmacs#projects#list_recent()
  let dirs = []
  let dir_map = {}
  for path in v:oldfiles
    if s:is_in_skiplist(path)
      continue
    endif
    let dir = fnamemodify(path, ':p:h')
    if !has_key(dir_map, dir)
      call add(dirs, dir)
      let dir_map[dir] = 1
    endif
  endfor

  let projects = []
  let project_map = {}
  for dir in dirs
    let project = jmacs#projects#get_project_for(dir)
    if !empty(project)
      if !has_key(project_map, project)
        call add(projects, project)
        let project_map[project] = 1
      endif
    endif
  endfor
  return projects
endfunction

function! jmacs#projects#get_project_for(path)
  return jmacs#rooter#search_for_project_root(a:path)
endfunction

function! jmacs#projects#current_project()
  return jmacs#projects#get_project_for(expand('%:p'))
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
  for file in a:lines[2:5]
    execute 'vsplit' file
  endfor
  " limit the number of splits, but still open the files for history, active
  " buffers etc.
  for file in a:lines[6:]
    execute 'edit' file
  endfor
endfunction

function! jmacs#projects#launch(dir)
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

function! jmacs#projects#ag()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
  else
    call fzf#vim#ag('', {'dir': dir})
  endif
endfunction

function! jmacs#projects#ag_cursor()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
  else
    let query = expand('<cword>')
    call fzf#vim#ag(query, {'dir': dir})
  endif
endfunction

function! jmacs#projects#ag_selection()
  let dir = jmacs#projects#current_project()
  if empty(dir)
    call jmacs#util#error('Not in a project')
  else
    let query = jmacs#util#get_selected_text()
    call fzf#vim#ag(query, {'dir': dir})
  endif
endfunction
