" this tries to jump to closed buffers, including transient states, that's annoying
call jmacs#bindings#register_binding('last buffer', ':b#<CR>', ['<Tab>'])
call jmacs#bindings#register_binding('shell command', ':! ', ['!'])
call jmacs#bindings#register_binding('terminal', ':terminal<CR>', ["'"])

" search project
" comment
