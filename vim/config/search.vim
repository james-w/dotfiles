function! Swoop()
  call fzf#vim#buffer_lines()
endfunction

function! SwoopCursor()
  let query = expand('<cword>')
  call fzf#vim#buffer_lines(query)
endfunction

function! SwoopSelection()
  let query = jmacs#util#get_selected_text()
  call fzf#vim#buffer_lines(query)
endfunction

call jmacs#bindings#register_call_binding('swoop', 'call Swoop()', g:jmacs_search_group, 's')
call jmacs#bindings#register_call_binding_v('swoop', 'call Swoop()', g:jmacs_search_group, 's')
call jmacs#bindings#register_call_binding('swoop region or symbol', 'call SwoopCursor()', g:jmacs_search_group, 'S')
call jmacs#bindings#register_call_binding_v('swoop region or symbol', 'call SwoopSelection()', g:jmacs_search_group, 'S')
call jmacs#bindings#register_call_binding('search current project', 'call jmacs#projects#ag()', g:jmacs_search_group, 'p')
call jmacs#bindings#register_call_binding_v('search current project', 'call jmacs#projects#ag()', g:jmacs_search_group, 'p')
call jmacs#bindings#register_call_binding('search current project with word under cursor', 'call jmacs#projects#ag_cursor()', g:jmacs_search_group, 'P')
call jmacs#bindings#register_call_binding_v('search current project with selection', 'call jmacs#projects#ag_selection()', g:jmacs_search_group, 'P')

function! s:current_dir()
  return expand('%:p:h')
endfunction

function! AgDirCurrentFile()
  let dir = s:current_dir()
  call fzf#vim#ag('', {'dir': dir})
endfunction

function! AgDirCurrentFileCursor()
  let dir = s:current_dir()
  let query = expand('<cword>')
  call fzf#vim#ag(query, {'dir': dir})
endfunction

function! AgDirCurrentFileSelection()
  let dir = s:current_dir()
  let query = jmacs#util#get_selected_text()
  call fzf#vim#ag(query, {'dir': dir})
endfunction

let s:ag_group = jmacs#bindings#register_group('ag', g:jmacs_search_group, 'a')
call jmacs#bindings#register_call_binding('dir of current file', 'call AgDirCurrentFile()', s:ag_group, 'd')
call jmacs#bindings#register_call_binding_v('dir of current file', 'call AgDirCurrentFile()', s:ag_group, 'd')
call jmacs#bindings#register_call_binding('dir of current file with word under cursor', 'call AgDirCurrentFileCursor()', s:ag_group, 'D')
call jmacs#bindings#register_call_binding_v('dir of current file with word under cursor', 'call AgDirCurrentFileSelection()', s:ag_group, 'D')
call jmacs#bindings#register_call_binding('current project', 'call jmacs#projects#ag()', s:ag_group, 'p')
call jmacs#bindings#register_call_binding_v('current project', 'call jmacs#projects#ag()', s:ag_group, 'p')
call jmacs#bindings#register_call_binding('current project with word under cursor', 'call jmacs#projects#ag_cursor()', s:ag_group, 'P')
call jmacs#bindings#register_call_binding_v('current project with selection', 'call jmacs#projects#ag_selection()', s:ag_group, 'P')
