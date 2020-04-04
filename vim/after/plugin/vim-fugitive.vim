let s:git_group = jmacs#bindings#register_group('git', g:jmacs_top_group, 'g')
call jmacs#bindings#register_binding('status', ":vertical Git<CR>", s:git_group, 's')
