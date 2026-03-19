" ftdetect/bear.vim
augroup bear_ftdetect
  autocmd!
  autocmd BufRead,BufNewFile *.br,*.bear set filetype=bear
augroup END
