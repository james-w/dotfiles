call jmacs#bindings#register_binding('nerdtree', ':NERDTreeToggle<CR>', g:jmacs_application_group, 't')
call jmacs#bindings#register_binding('find current file in nerdtree', ':NERDTreeFind<CR>', g:jmacs_application_group, 'T')

function! s:nerdtree_project()
    let dir = jmacs#projects#current_project()
    if empty(dir)
        call jmacs#util#error("Not in a project")
        return
    endif
    NERDTreeToggle
    let l:cwdPath = g:NERDTreePath.New(dir)
    let l:newRoot = g:NERDTreeFileNode.New(l:cwdPath, b:NERDTree)
    call b:NERDTree.changeRoot(l:newRoot)
endfunction

call jmacs#bindings#register_call_binding('nerdtree', 'call call(' . string(function('s:nerdtree_project')) . ', [])', g:jmacs_project_group, 't')
