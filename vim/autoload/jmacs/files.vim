function! s:create_file_sink(lines)
  if len(a:lines) < 1
    return
  end
  let dir = a:lines[0]
  call inputsave()
  let file = input('New file name: ')
  call inputrestore()
  let path = dir . '/' . file
  if !empty(file)
    execute 'e' path
  endif
endfunction

function! jmacs#files#new_file_in_dir(dir)
  let dirs = 'find . -path ./.git -prune -o -type d -print'
  return fzf#run(fzf#wrap('dirs', {'source': dirs, 'sink*': function('s:create_file_sink'), 'dir': a:dir, 'options': '+s +m --prompt="Dirs>" --preview=''tree -C {}'''}))
endfunction
