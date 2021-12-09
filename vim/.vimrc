syntax on
set cindent
set cinoptions=:0
set cscopequickfix=s-,c-,d-,i-,t-,e-
let g:DirDiffExcludes="*.o,*.d,*.out,*.swp,.svn,*.a"
let g:DirDiffAddArgs = "-w" 

if $VIM_HATE_SPACE_ERRORS != '0'
      let c_space_errors=1
endif

"set switchbuf=split

