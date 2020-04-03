function! LimelightOn()
  if has("gui_running") || &t_Co == 256
    Limelight
  endif
endfunction

function! LimelightOff()
  Limelight!
endfunction

autocmd! User GoyoEnter call LimelightOn()
autocmd! User GoyoLeave call LimelightOff()
