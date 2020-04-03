function! FocusMode()
    Goyo
endfunction

call g:JmacsRegisterGroup('ui toggles', ['T'])
call g:JmacsRegisterCallBinding('focus mode', 'call FocusMode()', ['T', 'f'])
