function! FocusMode()
    Goyo
endfunction

call jmacs#bindings#register_group('ui toggles', ['T'])
call jmacs#bindings#register_call_binding('focus mode', 'call FocusMode()', ['T', 'f'])
