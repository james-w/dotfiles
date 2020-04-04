" Adapted from rooter.vim

" Changes:
"   * Drop all code related to actually changing the dir
"   * Allow SearchForRootDirectory to be called on any path, not just the path of the current buffer

" Vim plugin to change the working directory to the project root.
"
" Copyright 2010-2016 Andrew Stewart, <boss@airbladesoftware.com>
" Released under the MIT licence.

" Modified to not change, but to be a library function on arbitrary paths

if !exists('g:jmacs_rooter_patterns')
  let g:jmacs_rooter_patterns = ['.git', '.git/', '_darcs/', '.hg/', '.bzr/', '.svn/']
endif

function! s:IsDirectory(pattern)
  return a:pattern[-1:] == '/'
endfunction

" Returns the ancestor directory of `path` matching `pattern`.
"
" The returned directory does not have a trailing path separator.
function! s:FindAncestor(path, pattern)
  let fd_dir = isdirectory(a:path) ? a:path : fnamemodify(a:path, ':h')
  let fd_dir_escaped = escape(fd_dir, ' ')

  if s:IsDirectory(a:pattern)
    let match = finddir(a:pattern, fd_dir_escaped.';')
  else
    let [_suffixesadd, &suffixesadd] = [&suffixesadd, '']
    let match = findfile(a:pattern, fd_dir_escaped.';')
    let &suffixesadd = _suffixesadd
  endif

  if empty(match)
    return ''
  endif

  if s:IsDirectory(a:pattern)
    " If the directory we found (`match`) is part of the file's path
    " it is the project root and we return it.
    "
    " Compare with trailing path separators to avoid false positives.
    if stridx(fnamemodify(fd_dir, ':p'), fnamemodify(match, ':p')) == 0
      return fnamemodify(match, ':p:h')

    " Else the directory we found (`match`) is a subdirectory of the
    " project root, so return match's parent.
    else
      return fnamemodify(match, ':p:h:h')
    endif

  else
    return fnamemodify(match, ':p:h')
  endif
endfunction

function! jmacs#rooter#search_for_project_root(path)
  for pattern in g:jmacs_rooter_patterns
    let result = s:FindAncestor(a:path, pattern)
    if !empty(result)
      return result
    endif
  endfor
  return ''
endfunction
