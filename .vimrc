
set nocompatible
source $VIMRUNTIME/vimrc_example.vim
source $VIMRUNTIME/mswin.vim
behave mswin

set diffexpr=MyDiff()
function MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '"' . $VIMRUNTIME . '\diff"'
      let eq = '""'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

set guifont=Source\ Code\ Pro:h11
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guioptions-=L

set backupdir=c:\\vim\\tmp,c:\\tmp,c:\\temp,.
set directory=c:\\vim\\tmp,c:\\tmp,c:\\temp,.
set undodir=c:\\vim\\undo,c:\\tmp,c:\\temp,.

set hidden

call plug#begin('~/.vim/plugged')

Plug 'scrooloose/nerdtree'

Plug 'zcodes/vim-colors-basic'

call plug#end()

set expandtab shiftwidth=3 tabstop=3
set number
set encoding=utf-8

noremap <silent> <F4> :execute 'NERDTreeToggle ' . getcwd()<CR>
noremap <silent> <F3> :new <CR>:setlocal buftype=nofile bufhidden=wipe nobl noswf<CR>

colorscheme basic-dark
