let s:lasttab = -1

au TabLeave * let s:lasttab = tabpagenr()

function! s:jump_to_previous(char)
  if s:lasttab > -1
    execute 'tabnext ' . s:lasttab
  endif
endfunction

function! s:jump_to_tab(char)
  if str2nr(a:char) > tabpagenr('$')
    echom "No such tab"
    return
  endif
  execute 'tabnext ' . a:char
endfunction

function! s:move_tab(char)
  if a:char ==# "<"
    if tabpagenr() > 1
      execute 'tabm -1'
    endif
  else
    if tabpagenr() < tabpagenr('$')
      execute 'tabm +1'
    endif
  endif
endfunction

function! s:get_tabs()
  let tabs = []
  let i = 1
  while i < tabpagenr('$') + 1
    let name = TabooTabName(i)
    let name = empty(name) ? '[untitled]' : name
    let buffers = tabpagebuflist(i)
    let bufnames = []
    for b in buffers
      if !buflisted(b)
        continue
      endif
      let bname = bufname(b)
      let line = getbufinfo(b)[0]['lnum']
      let target = line == 0 ? bname : bname.':'.line
      call add(bufnames, target)
    endfor
    call add(tabs, printf("%d\t%s\t%s", i, name, empty(bufnames) ? '' : string(bufnames)))
    let i = i+1
  endwhile
  return tabs
endfunction

function! s:layouts_sink(lines)
  if len(a:lines) < 1
    return
  endif
  let n = split(a:lines[0], '\t')[0]
  execute 'tabnext'  n
endfunction

function! s:list_layouts(char)
  let tabs = s:get_tabs()
  return fzf#run(fzf#wrap('tabs', {'source': tabs, 'sink*': function('s:layouts_sink'), 'options': '+s +m --prompt="Tabs>"'}))
endfunction

" moving between tabs hides the transient window, but it still operates
" deleting a tab causes an error as we then try to delete the transient state

function! s:layouts_transient_state() abort
  let state = _sv_api#import('transient_state')
  call state.set_title('Tabs(layouts) Transient State')
  call state.defind_keys(
        \ {
        \ 'layout' : 'vertical split',
        \ 'left' : [
        \ {
        \ 'key' : 'n',
        \ 'desc' : 'next',
        \ 'func' : '',
        \ 'cmd' : 'tabnext',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : 'p',
        \ 'desc' : 'previous',
        \ 'func' : '',
        \ 'cmd' : 'tabprevious',
        \ 'exit' : 0,
        \ },
        \ {
        \ 'key' : ['1', '2', '3', '4', '5', '6', '7', '8', '9'],
        \ 'desc' : 'jump to tab N',
        \ 'func' : function('s:jump_to_tab'),
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : "\<tab>",
        \ 'desc' : 'last visited',
        \ 'func' : function('s:jump_to_previous'),
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : 'l',
        \ 'desc' : 'list',
        \ 'func' : function('s:list_layouts'),
        \ 'cmd' : '',
        \ 'exit' : 1,
        \ },
        \ ],
        \ 'right' : [
        \ {
        \ 'key' : 'd',
        \ 'desc' : 'close tab',
        \ 'func' : '',
        \ 'cmd' : 'tabclose',
        \ 'exit' : 1,
        \ },
        \ {
        \ 'key' : ['<', '>'],
        \ 'desc' : 'move tab left/right',
        \ 'func' : function('s:move_tab'),
        \ 'cmd' : '',
        \ 'exit' : 0,
        \ },
        \ ],
        \ }
        \ )
  call state.open()
endfunction

" can this just use function() rather than stringing it?
call jmacs#bindings#register_call_binding('tabs(layouts) transient state', 'call call(' . string(function('s:layouts_transient_state')) . ', [])', g:jmacs_top_group, 'l')
