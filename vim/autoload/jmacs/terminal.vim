let s:terminals = {}

function! jmacs#terminal#toggle(dir) abort
    let this_term = get(s:terminals, a:dir, { 'win_id': v:null, 'buffer_id': v:null })
    if &buftype == 'terminal' || win_gotoid(this_term.win_id)
        " toggle off the terminal
        hide
        set laststatus=2 showmode ruler
    else
        botright new
        if !this_term.buffer_id || bufnr(this_term.buffer_id) == -1
            call term_start($SHELL, {'cwd': a:dir, 'stoponexit': 'term', 'term_kill': 'term', 'curwin': 1})
            let this_term.buffer_id = bufnr("")
        else
            exec "buffer" this_term.buffer_id
        endif

        let this_term.win_id = win_getid()
        let s:terminals[a:dir] = this_term
        exec "resize" float2nr(&lines * 0.25)
        setlocal noshowmode noruler wfh
        setlocal nobuflisted
        echo ''
        startinsert!


        " Double escape to get to normal mode in terminal
        tnoremap <Esc><Esc> <C-\><C-n>
        " q to quit in normal mode
        nnoremap <buffer><silent> q :q<CR>
        " Q to quit and kill term
        nnoremap <buffer><silent> Q :bw!<CR>
    endif
endfunction

function! jmacs#terminal#toggle_current() abort
    let project = jmacs#projects#current_project()
    if empty(project)
        let dir = expand('%:p:h')
        call jmacs#terminal#toggle(dir)
    else
        call jmacs#terminal#toggle(project)
    endif
endfunction
