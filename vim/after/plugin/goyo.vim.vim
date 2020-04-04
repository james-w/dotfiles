function! FocusMode()
    Goyo
endfunction

let s:toggles_group = jmacs#bindings#register_group('ui toggles', g:jmacs_top_group, 'T')
call jmacs#bindings#register_call_binding('focus mode', 'call FocusMode()', s:toggles_group, 'f')
