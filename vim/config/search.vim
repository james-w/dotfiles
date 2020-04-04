call jmacs#bindings#register_binding('swoop', ':BLines<CR>', g:jmacs_search_group, 's')

function! AgDirCurrentFile()
  let dir = expand('%:p:h')
  call fzf#vim#ag('', {'dir': dir})
endfunction

let s:ag_group = jmacs#bindings#register_group('ag', g:jmacs_search_group, 'a')
call jmacs#bindings#register_call_binding('dir of current file', 'call AgDirCurrentFile()', s:ag_group, 'd')
