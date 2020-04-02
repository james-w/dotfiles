call g:JmacsRegisterBinding('expand region', ":<C-U>call expand_region#next('n', '+')<CR>", 'v')
call g:JmacsRegisterBindingV('expand region', ":<C-U>call expand_region#next('v', '+')<CR>", 'v')
