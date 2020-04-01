let g:JmacsFilePrefix = 'f'

function! g:JmacsSetValue(value, ...)
  if a:0 < 1
    echoerr "insufficient key bindings"
  endif
  let map = g:which_key_map
  let i = 0
  while i < a:0 - 1
    let map = map[a:000[i]]
    let i += 1
  endwhile
  let map[a:000[a:0-1]] = a:value
endfunction

function! g:JmacsRegisterGroup(name, ...)
  if a:0 < 1
    echoerr "insufficient key bindings"
  endif
  call call("g:JmacsSetValue", [{'name': '+' . a:name}] + a:000)
endfunction

function! g:JmacsRegisterBinding(name, action, ...)
  if a:0 < 1
    echoerr "insufficient key bindings"
  endif
  let keys = join(['<leader>'] + a:000, '')
  execute 'nnoremap' . keys ' ' . a:action
  call call('g:JmacsSetValue', [a:name] + a:000)
endfunction

function! g:JmacsRegisterFileBinding(name, action, ...)
  if a:0 < 1
    echoerr "insufficient key bindings"
  endif
  call call('g:JmacsRegisterBinding', [a:name, a:action, g:JmacsFilePrefix] + a:000)
endfunction
