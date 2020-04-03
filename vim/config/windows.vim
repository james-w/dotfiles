let s:WindowsPrefix = 'w'

call g:JmacsRegisterGroup('windows', [s:WindowsPrefix])

call g:JmacsRegisterBinding('alternate window', '<C-w><C-p>', [s:WindowsPrefix, '<Tab>'])
call g:JmacsRegisterBinding('new horizontal split', ':split<CR>', [s:WindowsPrefix, '-'])
call g:JmacsRegisterBinding('new vertical split', ':vsplit<CR>', [s:WindowsPrefix, '/'])
call g:JmacsRegisterBinding('equalize splits', '<C-w>=', [s:WindowsPrefix, '='])
call g:JmacsRegisterBinding('shrink horizontally', ':vertical resize -2<CR>', [s:WindowsPrefix, '['])
call g:JmacsRegisterBinding('grow horizontally', ':vertical resize +2<CR>', [s:WindowsPrefix, ']'])
call g:JmacsRegisterBinding('shrink vertically', ':resize -2<CR>', [s:WindowsPrefix, '{'])
call g:JmacsRegisterBinding('grow vertically', ':resize +2<CR>', [s:WindowsPrefix, '}'])
call g:JmacsRegisterBinding('maximise horizontally', ':vertical resize<CR>', [s:WindowsPrefix, '_'])
call g:JmacsRegisterBinding('maximise vertically', ':resize<CR>', [s:WindowsPrefix, '\|'])
call g:JmacsRegisterBinding('close window', '<C-w>c', [s:WindowsPrefix, 'd'])
call g:JmacsRegisterBinding('move to window on left', '<C-w>h', [s:WindowsPrefix, 'h'])
call g:JmacsRegisterBinding('move to window on right', '<C-w>l', [s:WindowsPrefix, 'l'])
call g:JmacsRegisterBinding('move to window above', '<C-w>k', [s:WindowsPrefix, 'k'])
call g:JmacsRegisterBinding('move to window below', '<C-w>j', [s:WindowsPrefix, 'j'])
call g:JmacsRegisterBinding('move this window left', '<C-w>H', [s:WindowsPrefix, 'H'])
call g:JmacsRegisterBinding('move this window right', '<C-w>L', [s:WindowsPrefix, 'L'])
call g:JmacsRegisterBinding('move this window up', '<C-w>K', [s:WindowsPrefix, 'K'])
call g:JmacsRegisterBinding('move this window down', '<C-w>J', [s:WindowsPrefix, 'J'])
call g:JmacsRegisterBinding('swap window', '<C-w>m', [s:WindowsPrefix, 'M'])
call g:JmacsRegisterBinding('maximise window', '<C-w>o', [s:WindowsPrefix, 'm'])
call g:JmacsRegisterBinding('rotate windows forward', '<C-w>r', [s:WindowsPrefix, 'r'])
call g:JmacsRegisterBinding('rotate windows backward', '<C-w>R', [s:WindowsPrefix, 'R'])
call g:JmacsRegisterBinding('new horizontal split', ':split<CR>', [s:WindowsPrefix, 's'])
call g:JmacsRegisterBinding('new horizontal split and focus', ':split<CR><C-w>j', [s:WindowsPrefix, 'S'])
call g:JmacsRegisterBinding('new horizontal split', ':vsplit<CR>', [s:WindowsPrefix, 'v'])
call g:JmacsRegisterBinding('new horizontal split and focus', ':vsplit<CR><C-w>l', [s:WindowsPrefix, 'V'])
call g:JmacsRegisterBinding('kill window and buffer', ':confirm quit<CR>', [s:WindowsPrefix, 'x'])

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

call g:JmacsRegisterCallBinding('resize transient state', 'call call(' . string(function('s:win_resize_transient_state')) . ', [])', [s:WindowsPrefix, "."])
