" for vim-gitgutter
" highlight clear SignColumn
" highlight GitGutterAdd ctermfg=green guifg=darkgreen
" highlight GitGutterChange ctermfg=yellow guifg=darkyellow
" highlight GitGutterDelete ctermfg=red guifg=darkred
" highlight GitGutterChangeDelete ctermfg=yellow guifg=darkyellow

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

function! s:create_branch_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let source = a:lines[0]
  call inputsave()
  let term = input('New branch name: ')
  call inputrestore()
  execute ':Git checkout -b' term source
endfunction

function! s:switch_branch_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let branch = a:lines[0]
  execute ':Git checkout ' branch
endfunction

function! s:fzf_branches(dir, sink)
  return fzf#run(fzf#wrap('branches', {'source': '(git branch -a | cut -c 3-)', 'sink*': a:sink, 'dir': a:dir, 'options': '+m --prompt="Branches>" --preview "git show --color=always {1}"'}))
endfunction

function s:branch(char)
  let dir = jmacs#projects#current_project()
  if empty(dir)
      dir = getcwd()
  endif
  return s:fzf_branches(dir, function('s:create_branch_sink'))
endfunction

function s:checkout(char)
  let dir = jmacs#projects#current_project()
  if empty(dir)
      dir = getcwd()
  endif
  return s:fzf_branches(dir, function('s:switch_branch_sink'))
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
        \ 'key' : 'b',
        \ 'desc' : 'checkout branch',
        \ 'func' : function('s:checkout'),
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'B',
        \ 'desc' : 'create branch',
        \ 'func' : function('s:branch'),
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'c',
        \ 'desc' : 'commit',
        \ 'func' : '',
        \ 'cmd' : ':Git commit',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'f',
        \ 'desc' : 'fetch',
        \ 'func' : '',
        \ 'cmd' : ':Git fetch',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'F',
        \ 'desc' : 'pull',
        \ 'func' : '',
        \ 'cmd' : ':Git pull',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'p',
        \ 'desc' : 'push',
        \ 'func' : '',
        \ 'cmd' : ':Git push',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'S',
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
