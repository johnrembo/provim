local dadbod = require("vim-dadbod")

vim.cmd([[
set nospell

" default was <C-C>, which is weird
let g:ftplugin_sql_omni_key = '<C-s>'
" default dialect
let g:sql_type_default = 'plsql'
" prefer exact match
let g:completion_matching_strategy_list = ['exact', 'substring']
" do not need case sensitivity here
let g:completion_matching_ignore_case = 1
" limit suggestion list
set pumheight=20

" dotenv wrapper
function! s:env(var) abort
	return exists('*DotenvGet') ? DotenvGet(a:var) : eval('$'.a:var)
endfunction

" Dbext

" default profiles
let g:dbext_default_profile_oracle = s:env('DATABASE_EXT')

" Dadbod

let b:db = s:env('DATABASE_URL')
" completion menu label
let g:vim_dadbod_completion_mark = ''
" use lower case where possible
let g:vim_dadbod_prefer_lowercase = 1
]])
