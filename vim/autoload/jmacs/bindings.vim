" for vim-which-key
let g:which_key_map = {}

function! jmacs#bindings#set_value(value, keys, remap)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let map = g:which_key_map
  let i = 0
  while i < len(a:keys) - 1
    let key = a:keys[i]
    if !has_key(map, key)
      echoerr 'Unregistered group prefix (during ' . a:value . '): ' . join(a:keys[:i], '')
    endif
    let map = map[key]
    let i += 1
  endwhile
  let key = a:keys[len(a:keys)-1]
  if !a:remap && has_key(map, key)
    echoerr 'Mapping already registered to ' . map[key] . ' (during ' . a:value . '): ' . join(a:keys, '')
  endif
  let map[key] = a:value
endfunction

function! jmacs#bindings#register_group(name, group, key)
  let new_group = deepcopy(a:group)
  call add(new_group.keys, a:key)
  call jmacs#bindings#set_value({'name': '+' . a:name}, new_group.keys, 0)
  return new_group
endfunction

function! jmacs#bindings#register_raw(name, action, group, key, n, v, is_call, opts)
  let nkeys = join(['<leader>'] + a:group.keys + [a:key], '')
  let action = a:is_call ? ':<C-u>' . a:action . '<CR>' : a:action
  if a:n
    if get(a:opts, 'silent', 0)
        execute 'nmap <silent>' nkeys action
    else
        execute 'nmap' nkeys action
    endif
  endif
  if a:v
    if get(a:opts, 'silent', 0)
        execute 'vmap <silent>' nkeys action
    else
        execute 'vmap' nkeys action
    endif
  endif
  " There doesn't seem to be a separate map for visual mode
  call jmacs#bindings#set_value(a:name, a:group.keys + [a:key], get(a:opts, 'remap', 0))
endfunction

function! jmacs#bindings#register_binding(name, action, group, key)
  call jmacs#bindings#register_raw(a:name, a:action, a:group, a:key, 1, 0, 0, {})
endfunction

function! jmacs#bindings#register_binding_silent(name, action, group, key)
  call jmacs#bindings#register_raw(a:name, a:action, a:group, a:key, 1, 0, 0, {'silent': 1})
endfunction

function! jmacs#bindings#register_call_binding(name, action, group, key)
  call jmacs#bindings#register_raw(a:name, a:action, a:group, a:key, 1, 0, 1, {})
endfunction

function! jmacs#bindings#register_binding_v(name, action, group, key)
  " we allow remap as these are usually already bound in normal mode
  call jmacs#bindings#register_raw(a:name, a:action, a:group, a:key, 0, 1, 0, {'remap': 1})
endfunction

function! jmacs#bindings#register_call_binding_v(name, action, group, key)
  " we allow remap as these are usually already bound in normal mode
  call jmacs#bindings#register_raw(a:name, a:action, a:group, a:key, 0, 1, 1, {'remap': 1})
endfunction

let g:jmacs_top_group = {'keys': []}
let g:jmacs_application_group = jmacs#bindings#register_group('applications', g:jmacs_top_group, 'a')
let g:jmacs_buffers_group = jmacs#bindings#register_group('buffers', g:jmacs_top_group, 'b')
let g:jmacs_compile_group = jmacs#bindings#register_group('compile/comments', g:jmacs_top_group, 'c')
let g:jmacs_comments_group = g:jmacs_compile_group
let g:jmacs_errors_group = jmacs#bindings#register_group('errors/code', g:jmacs_top_group, 'e')
let g:jmacs_code_group = g:jmacs_errors_group
let g:jmacs_file_group = jmacs#bindings#register_group('files', g:jmacs_top_group, 'f')
let g:jmacs_git_group = jmacs#bindings#register_group('git', g:jmacs_top_group, 'g')
let g:jmacs_project_group = jmacs#bindings#register_group('project', g:jmacs_top_group, 'p')
let g:jmacs_search_group = jmacs#bindings#register_group('search', g:jmacs_top_group, 's')
let g:jmacs_uitoggles_group = jmacs#bindings#register_group('ui toggles', g:jmacs_top_group, 'T')
