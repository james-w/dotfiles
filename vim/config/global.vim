" this tries to jump to closed buffers, including transient states, that's annoying
call jmacs#bindings#register_binding('last buffer', ':b#<CR>', g:jmacs_top_group, '<Tab>')
call jmacs#bindings#register_binding('shell command', ':! ', g:jmacs_top_group, '!')
call jmacs#bindings#register_binding('terminal', ':terminal<CR>', g:jmacs_top_group, "'")

" search project
" comment
