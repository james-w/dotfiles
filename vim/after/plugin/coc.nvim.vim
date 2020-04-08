" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

call jmacs#bindings#register_binding_silent('autofix current', "<Plug>(coc-fix-current)", g:jmacs_errors_group, 'a')
call jmacs#bindings#register_binding_silent('next diagnostic', "<Plug>(coc-diagnostic-next)", g:jmacs_errors_group, 'j')
call jmacs#bindings#register_binding_silent('previous diagnostic', '<Plug>(coc-diagnostic-prev)', g:jmacs_errors_group, 'k')
call jmacs#bindings#register_binding_silent('show current diagnostic', '<Plug>(coc-diagnostic-info)', g:jmacs_errors_group, 's')
call jmacs#bindings#register_binding_silent('list diagnostics', ':<C-u>CocList diagnostics<cr>', g:jmacs_errors_group, 'L')

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

call jmacs#bindings#register_binding_silent('show documentation', ':<C-u>call call(' . string(function('s:show_documentation')) . ', [])<CR>', g:jmacs_code_group, 'd')

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience as it controls CursorHold timeout
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

call jmacs#bindings#register_binding('format selection', '<Plug>(coc-format-selected)', g:jmacs_code_group, 'f')
call jmacs#bindings#register_binding_v('format selection', '<Plug>(coc-format-selected)', g:jmacs_code_group, 'f')
call jmacs#bindings#register_binding('format file', '<Plug>(coc-format)', g:jmacs_code_group, 'F')
call jmacs#bindings#register_call_binding('organise inputs', 'call CocAction(''runCommand'', ''editor.action.organizeImport'')', g:jmacs_code_group, 'I')
call jmacs#bindings#register_binding('rename symbol', '<Plug>(coc-rename)', g:jmacs_code_group, 'R')

let s:goto_group = jmacs#bindings#register_group('goto', g:jmacs_code_group, 'g')

call jmacs#bindings#register_binding_silent('definition', '<Plug>(coc-definition)', s:goto_group, 'd')
call jmacs#bindings#register_binding_silent('type definition', '<Plug>(coc-type-definition)', s:goto_group, 't')
call jmacs#bindings#register_binding_silent('implementation', '<Plug>(coc-implementation)', s:goto_group, 'i')
call jmacs#bindings#register_binding_silent('references', '<Plug>(coc-references)', s:goto_group, 'r')

" Introduce function text object
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)
