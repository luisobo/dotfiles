set nocompatible
syntax on
set nu
filetype plugin indent on

runtime! macros/matchit.vim


augroup myfiletypes
  autocmd!
  autocmd FileType ruby,eryby,yaml set ai sw=2 sts=2 et
augroup END
