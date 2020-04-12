let s:preview_window = v:null

function jmacs#html_preview#html_preview(url)
    let curwin = win_getid()
    if win_gotoid(s:preview_window)
        execute '1,$d'
    else
        botright vert new
        setlocal buftype=nofile bufhidden=hide noswapfile
        let s:preview_window = win_getid()
    endif
    execute 'r !elinks ' . a:url . ' -dump -dump-width ' . winwidth(0)
    call win_gotoid(curwin)
endfunction

function jmacs#html_preview#html_preview_current_file()
    call jmacs#html_preview#html_preview(expand('%:p'))
endfunction

function jmacs#html_preview#markdown_preview(path)
    let curwin = win_getid()
    let curline = line('.')
    if win_gotoid(s:preview_window)
        execute '1,$d'
    else
        botright vert new
        setlocal buftype=nofile bufhidden=hide noswapfile
        let s:preview_window = win_getid()
    endif
    execute 'r !cat ' . a:path . ' | markdown | elinks -dump -dump-width ' . winwidth(0)
    execute 'normal ' . curline . 'G'
    call win_gotoid(curwin)
endfunction

function jmacs#html_preview#markdown_preview_current_file()
    call jmacs#html_preview#markdown_preview(expand('%:p'))
endfunction

function jmacs#html_preview#markdown_preview_current_buffer()
    let curwin = win_getid()
    let curline = line('.')
    let buff=join(getline(1, '$'), "\n")
    if win_gotoid(s:preview_window)
        setlocal modifiable
        execute '1,$d'
    else
        botright vert new
        setlocal buftype=nofile bufhidden=hide noswapfile
        let s:preview_window = win_getid()
    endif
    let output = system('markdown | elinks -dump -dump-width ' . (winwidth(0) - 20), buff)
    put =output
    setlocal nomodifiable
    execute 'normal ' . curline . 'G'
    call win_gotoid(curwin)
endfunction

function jmacs#html_preview#toggle_live_markdown_preview()
    call jmacs#html_preview#markdown_preview_current_buffer()
    augroup MarkdownPreview
        autocmd!
        autocmd TextChanged <buffer> call jmacs#html_preview#markdown_preview_current_buffer()
        autocmd TextChangedI <buffer> call jmacs#html_preview#markdown_preview_current_buffer()
    augroup END
endfunction
