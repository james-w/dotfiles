let g:JmacsApplicationPrefix = 'a'
let g:JmacsFilePrefix = 'f'
let g:JmacsSearchPrefix = 's'
let g:JmacsProjectPrefix = 'p'

" for vim-which-key
let g:which_key_map = {}

function! jmacs#bindings#set_value(value, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let map = g:which_key_map
  let i = 0
  while i < len(a:keys) - 1
    let map = map[a:keys[i]]
    let i += 1
  endwhile
  let map[a:keys[len(a:keys)-1]] = a:value
endfunction

function! jmacs#bindings#register_group(name, keys)
  call jmacs#bindings#set_value({'name': '+' . a:name}, a:keys)
endfunction

function! jmacs#bindings#register_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let nkeys = join(['<leader>'] + a:keys, '')
  execute 'nnoremap' . nkeys . ' ' . a:action
  call jmacs#bindings#set_value(a:name, a:keys)
endfunction

function! jmacs#bindings#register_call_binding(name, action, keys)
  call jmacs#bindings#register_binding(a:name, ':<C-u>' . a:action . '<CR>', a:keys)
endfunction

function! jmacs#bindings#register_binding_v(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let keys = join(['<leader>'] + a:keys, '')
  execute 'vnoremap' . keys . ' ' . a:action
  " There doesn't seem to be a separate map for visual mode
  call jmacs#bindings#set_value(a:name, a:keys)
endfunction

function! jmacs#bindings#register_call_binding_v(name, action, keys)
  call jmacs#bindings#register_binding_v(a:name, ':<C-u>' . a:action . '<CR>', a:keys)
endfunction

function! jmacs#bindings#register_file_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_binding(a:name, a:action, [g:JmacsFilePrefix] + a:keys)
endfunction

function! jmacs#bindings#register_application_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_binding(a:name, a:action, [g:JmacsApplicationPrefix] + a:keys)
endfunction

function! jmacs#bindings#register_search_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_binding(a:name, a:action, [g:JmacsSearchPrefix] + a:keys)
endfunction

function! jmacs#bindings#register_search_call_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_call_binding(a:name, a:action, [g:JmacsSearchPrefix] + a:keys)
endfunction

function! jmacs#bindings#register_project_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_binding(a:name, a:action, [g:JmacsProjectPrefix] + a:keys)
endfunction

function! jmacs#bindings#register_project_call_binding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call jmacs#bindings#register_call_binding(a:name, a:action, [g:JmacsProjectPrefix] + a:keys)
endfunction
