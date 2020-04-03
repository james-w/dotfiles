let s:WindowsPrefix = 'w'

call jmacs#bindings#register_group('windows', [s:WindowsPrefix])

call jmacs#bindings#register_binding('alternate window', '<C-w><C-p>', [s:WindowsPrefix, '<Tab>'])
call jmacs#bindings#register_binding('new horizontal split', ':split<CR>', [s:WindowsPrefix, '-'])
call jmacs#bindings#register_binding('new vertical split', ':vsplit<CR>', [s:WindowsPrefix, '/'])
call jmacs#bindings#register_binding('equalize splits', '<C-w>=', [s:WindowsPrefix, '='])
call jmacs#bindings#register_binding('shrink horizontally', ':vertical resize -2<CR>', [s:WindowsPrefix, '['])
call jmacs#bindings#register_binding('grow horizontally', ':vertical resize +2<CR>', [s:WindowsPrefix, ']'])
call jmacs#bindings#register_binding('shrink vertically', ':resize -2<CR>', [s:WindowsPrefix, '{'])
call jmacs#bindings#register_binding('grow vertically', ':resize +2<CR>', [s:WindowsPrefix, '}'])
call jmacs#bindings#register_binding('maximise horizontally', ':vertical resize<CR>', [s:WindowsPrefix, '_'])
call jmacs#bindings#register_binding('maximise vertically', ':resize<CR>', [s:WindowsPrefix, '\|'])
call jmacs#bindings#register_binding('close window', '<C-w>c', [s:WindowsPrefix, 'd'])
call jmacs#bindings#register_binding('move to window on left', '<C-w>h', [s:WindowsPrefix, 'h'])
call jmacs#bindings#register_binding('move to window on right', '<C-w>l', [s:WindowsPrefix, 'l'])
call jmacs#bindings#register_binding('move to window above', '<C-w>k', [s:WindowsPrefix, 'k'])
call jmacs#bindings#register_binding('move to window below', '<C-w>j', [s:WindowsPrefix, 'j'])
call jmacs#bindings#register_binding('move this window left', '<C-w>H', [s:WindowsPrefix, 'H'])
call jmacs#bindings#register_binding('move this window right', '<C-w>L', [s:WindowsPrefix, 'L'])
call jmacs#bindings#register_binding('move this window up', '<C-w>K', [s:WindowsPrefix, 'K'])
call jmacs#bindings#register_binding('move this window down', '<C-w>J', [s:WindowsPrefix, 'J'])
call jmacs#bindings#register_binding('swap window', '<C-w>m', [s:WindowsPrefix, 'M'])
call jmacs#bindings#register_binding('maximise window', '<C-w>o', [s:WindowsPrefix, 'm'])
call jmacs#bindings#register_binding('rotate windows forward', '<C-w>r', [s:WindowsPrefix, 'r'])
call jmacs#bindings#register_binding('rotate windows backward', '<C-w>R', [s:WindowsPrefix, 'R'])
call jmacs#bindings#register_binding('new horizontal split', ':split<CR>', [s:WindowsPrefix, 's'])
call jmacs#bindings#register_binding('new horizontal split and focus', ':split<CR><C-w>j', [s:WindowsPrefix, 'S'])
call jmacs#bindings#register_binding('new horizontal split', ':vsplit<CR>', [s:WindowsPrefix, 'v'])
call jmacs#bindings#register_binding('new horizontal split and focus', ':vsplit<CR><C-w>l', [s:WindowsPrefix, 'V'])
call jmacs#bindings#register_binding('kill window and buffer', ':confirm quit<CR>', [s:WindowsPrefix, 'x'])

function! s:win_resize_transient_state() abort
  let state = _sv_api#import('transient_state')
  call state.set_title('Windows Resize Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : 'H',
        \ 'desc' : 'left',
        \ 'func' : '',
        \ 'cmd' : 'wincmd h',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'J',
        \ 'desc' : 'below',
        \ 'func' : '',
        \ 'cmd' : 'wincmd j',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'K',
        \ 'desc' : 'up',
        \ 'func' : '',
        \ 'cmd' : 'wincmd k',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'L',
        \ 'desc' : 'right',
        \ 'func' : '',
        \ 'cmd' : 'wincmd l',
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : 'h',
        \ 'desc' : 'decrease width',
        \ 'func' : '',
        \ 'cmd' : 'vertical resize -1',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'l',
        \ 'desc' : 'increase width',
        \ 'func' : '',
        \ 'cmd' : 'vertical resize +1',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'j',
        \ 'desc' : 'decrease height',
        \ 'func' : '',
        \ 'cmd' : 'resize -1',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'k',
        \ 'desc' : 'increase height',
        \ 'func' : '',
        \ 'cmd' : 'resize +1',
        \ 'exit' : 0,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
endfunction

call jmacs#bindings#register_call_binding('resize transient state', 'call call(' . string(function('s:win_resize_transient_state')) . ', [])', [s:WindowsPrefix, "."])
