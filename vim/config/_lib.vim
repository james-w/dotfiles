let g:JmacsApplicationPrefix = 'a'
let g:JmacsFilePrefix = 'f'
let g:JmacsSearchPrefix = 's'

" for vim-which-key
let g:which_key_map = {}

function! g:JmacsSetValue(value, keys)
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

function! g:JmacsRegisterGroup(name, keys)
  call g:JmacsSetValue({'name': '+' . a:name}, a:keys)
endfunction

function! g:JmacsRegisterBinding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let nkeys = join(['<leader>'] + a:keys, '')
  execute 'nnoremap' . nkeys . ' ' . a:action
  call g:JmacsSetValue(a:name, a:keys)
endfunction

function! g:JmacsRegisterCallBinding(name, action, keys)
  call g:JmacsRegisterBinding(a:name, ':<C-u>' . a:action . '<CR>', a:keys)
endfunction

function! g:JmacsRegisterBindingV(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  let keys = join(['<leader>'] + a:keys, '')
  execute 'vnoremap' . keys . ' ' . a:action
  " There doesn't seem to be a separate map for visual mode
  call g:JmacsSetValue(a:name, a:keys)
endfunction

function! g:JmacsRegisterCallBindingV(name, action, keys)
  call g:JmacsRegisterBindingV(a:name, ':<C-u>' . a:action . '<CR>', a:keys)
endfunction

function! g:JmacsRegisterFileBinding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call g:JmacsRegisterBinding(a:name, a:action, [g:JmacsFilePrefix] + a:keys)
endfunction

function! g:JmacsRegisterApplicationBinding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call g:JmacsRegisterBinding(a:name, a:action, [g:JmacsApplicationPrefix] + a:keys)
endfunction

function! g:JmacsRegisterSearchBinding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call g:JmacsRegisterBinding(a:name, a:action, [g:JmacsSearchPrefix] + a:keys)
endfunction

function! g:JmacsRegisterSearchCallBinding(name, action, keys)
  if len(a:keys) < 1
    echoerr "insufficient key bindings"
  endif
  call g:JmacsRegisterCallBinding(a:name, a:action, [g:JmacsSearchPrefix] + a:keys)
endfunction
