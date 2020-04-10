" this tries to jump to closed buffers, including transient states, that's annoying
call jmacs#bindings#register_binding('last buffer', ':b#<CR>', g:jmacs_top_group, '<Tab>')
call jmacs#bindings#register_binding('shell command', ':! ', g:jmacs_top_group, '!')
call jmacs#bindings#register_call_binding('terminal', 'call jmacs#terminal#toggle_current()', g:jmacs_top_group, "'")
call jmacs#bindings#register_binding('commands (have to press quickly)', ':Commands<CR>', g:jmacs_top_group, '<Space>')
call jmacs#bindings#register_binding('keybindings', ':Maps<CR> ', g:jmacs_top_group, '?')
call jmacs#bindings#register_binding('help (have to press quickly)', ':Helptags<CR> ', g:jmacs_top_group, '<F1>')

call jmacs#bindings#register_call_binding('search in project', 'call jmacs#projects#ag()', g:jmacs_top_group, '/')
call jmacs#bindings#register_call_binding_v('search in project', 'call jmacs#projects#ag()', g:jmacs_top_group, '/')
call jmacs#bindings#register_call_binding('search in project with word under cursor', 'call jmacs#projects#ag_cursor()', g:jmacs_top_group, '*')
call jmacs#bindings#register_call_binding_v('search in project with selection', 'call jmacs#projects#ag_selection()', g:jmacs_top_group, '*')

" comment
