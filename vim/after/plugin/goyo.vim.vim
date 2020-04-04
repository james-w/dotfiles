function! FocusMode()
    Goyo
endfunction

call jmacs#bindings#register_call_binding('focus mode', 'call FocusMode()', g:jmacs_uitoggles_group, 'f')
