let g:startify_fortune_use_unicode = 1
let g:startify_custom_header = 'startify#pad(["Hit space..."])'

function! s:load_project(project)
  call jmacs#projects#launch(a:project)
endfunction

function! s:list_projects()
  let projects = jmacs#projects#list_recent()
  let lines = []
  for project in projects
    call add(lines, { 'line': project, 'cmd': 'call call(' . string(function('s:load_project')) . ', ["' . project . '"])' })
  endfor
  return lines
endfunction

let g:startify_lists = [
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'dir',       'header': ['   MRU '. getcwd()] },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': function('s:list_projects'),  'header': ['   Projects']       },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ { 'type': 'commands',  'header': ['   Commands']       },
\ ]
