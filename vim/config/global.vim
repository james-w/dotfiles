" this tries to jump to closed buffers, including transient states, that's annoying
call g:JmacsRegisterBinding('last buffer', ':b#<CR>', ['<Tab>'])
call g:JmacsRegisterBinding('shell command', ':! ', ['!'])
call g:JmacsRegisterBinding('terminal', ':terminal<CR>', ["'"])

" search project
" comment
