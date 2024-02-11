nmap <buffer> <Leader>li :PhpactorImportClass<CR>
nmap <buffer> <Leader>lce :PhpactorClassExpand<CR>
nmap <buffer> <Leader>lim :PhpactorImportMissingClasses<CR>
nmap <buffer> <Leader>lm :PhpactorContextMenu<CR>
nmap <buffer> <Leader>ln :PhpactorNavigate<CR>
nmap <buffer> <Leader>o :PhpactorGotoDefinition edit<CR>
nmap <buffer> <Leader>K :PhpactorHover<CR>
nmap <buffer> <Leader>lt :PhpactorTransform<CR>
nmap <buffer> <Leader>lcn :PhpactorClassNew<CR>
nmap <buffer> <Leader>lci :PhpactorClassInflect<CR>
nmap <buffer> <Leader>lr :PhpactorFindReferences<CR>
nmap <buffer> <Leader>mf :PhpactorMoveFile<CR>
nmap <buffer> <Leader>cf :PhpactorCopyFile<CR>
nmap <buffer> <silent> <Leader>lee :PhpactorExtractExpression<CR>
vmap <buffer> <silent> <Leader>lee :<C-u>PhpactorExtractExpression<CR>
vmap <buffer> <silent> <Leader>lem :<C-u>PhpactorExtractMethod<CR>

let Vimphpcs_Standard='PSR12'

autocmd FileType php set iskeyword+=$