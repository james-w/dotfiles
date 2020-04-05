call jmacs#bindings#register_binding('comment or uncomment lines', '<Plug>TComment_gcc', g:jmacs_comments_group, 'l')
call jmacs#bindings#register_binding_v('comment or uncomment selection', 'gc', g:jmacs_comments_group, 'l')
call jmacs#bindings#register_binding('comment and copy', 'yygccp', g:jmacs_comments_group, 'y')
call jmacs#bindings#register_binding_v('comment and copy', 'ygcp', g:jmacs_comments_group, 'y')
