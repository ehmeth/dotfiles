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
set backspace=2   " Backspace deletes like most programs in insert mode
set nobackup
set nowritebackup
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set hlsearch
set cursorline

noremap <silent> <F4> :execute 'NERDTreeToggle ' . getcwd()<CR>
noremap <silent> <F3> :new <CR>:setlocal buftype=nofile bufhidden=wipe nobl noswf<CR>

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
if executable('ag')
   " Use Ag over Grep
   set grepprg=ag\ --nogroup\ --nocolor
   
   " Use ag in fzf for listing files. Lightning fast and respects .gitignore
   let $FZF_DEFAULT_COMMAND = 'ag --literal --files-with-matches --nocolor --hidden -g ""'

   if !exists(":Ag")
      command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
      nnoremap \ :Ag<SPACE>
   endif
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

colorscheme basic-dark
