" for vim-gitgutter
highlight clear SignColumn
highlight GitGutterAdd ctermfg=green guifg=darkgreen
highlight GitGutterChange ctermfg=yellow guifg=darkyellow
highlight GitGutterDelete ctermfg=red guifg=darkred
highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

function! s:next_hunk(char)
  call gitgutter#hunk#next_hunk(1)
endfunction

function! s:prev_hunk(char)
  call gitgutter#hunk#prev_hunk(1)
endfunction

function! s:revert_hunk(char)
  call gitgutter#hunk#undo()
endfunction

function! s:stage_hunk(char)
  call gitgutter#hunk#stage()
endfunction

function! s:git_transient_state() abort
  let state = _sv_api#import('transient_state')
  call state.set_title('Git Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : 'n',
        \ 'desc' : 'next hunk',
        \ 'func' : function('s:next_hunk'),
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : ['p', 'N'],
        \ 'desc' : 'previous hunk',
        \ 'func' : function('s:prev_hunk'),
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'r',
        \ 'desc' : 'revert',
        \ 'func' : function('s:revert_hunk'),
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 's',
        \ 'desc' : 'stage',
        \ 'func' : function('s:stage_hunk'),
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : 'c',
        \ 'desc' : 'commit',
        \ 'func' : '',
        \ 'cmd' : ':Git commit',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 's',
        \ 'desc' : 'status',
        \ 'func' : '',
        \ 'cmd' : ':Git',
        \ 'exit' : 1,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
endfunction

call jmacs#bindings#register_call_binding('git transient state', 'call call(' . string(function('s:git_transient_state')) . ', [])', g:jmacs_git_group, '.')
