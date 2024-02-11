Про Vim " Плагины NeoVim


# vim-dadbod

Не совсем понял почему, но мне пришлось вручную перетащить `~/.local/share/nvim/site/pack/packer/opt/dbext.vim` в `~/.local/share/nvim/site/pack/packer/start/dbext.vim` дабы иметь возможность настроить соединения к базе при открытии файлов.

Добавляем в `.config/nvim/ftplugin/sql.lua` скрипт настройки переменных из конфигурации Vim. 

```
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

```

Переводить на Lua поленился.

# vim-dadbod-completion

# ALE + psalm

```
use("dense-analysis")

composer require --dev vimeo/psalm -W

./vendor/bin/psalm --init

./vendor/bin/psalm

  301  git clone git@github.com:phpactor/phpactor
  302  cd phpactor
  303  composer install
  304  rm ~/.local/bin/phpactor
  305  cd ~/.local/bin
  306  mv -R ~/src/php/PHPLogger/src/phpactor ~/src
  307  mv ~/src/php/PHPLogger/src/phpactor ~/src
  308  ln -s ~/src/phpactor/bin/phpactor phpactor

             use({
~  27             "gbprod/phpactor.nvim",
~  26             -- run = require("phpactor.handler.update"), -- To install/update phpactor when installing this plugin
~  25             requires = {
~  24                 "nvim-lua/plenary.nvim", -- required to update phpactor
~  23                 "neovim/nvim-lspconfig" -- required to automaticly register lsp serveur
+  22             },
+  21             config = function()
+  20                 require("phpactor").setup({
+  19                     install = {
+  18                         path = vim.fn.stdpath("data") .. "/opt/",
+  17                         branch = "master",
+  16                         bin = vim.fn.expand("$HOME/.local/bin/phpactor"),
+  15                         php_bin = "php",
+  14                         composer_bin = "composer",
+  13                         git_bin = "git",
+  12                         check_on_startup = "none",
+  11                       },
+  10                       lspconfig = {
+   9                           enabled = true,
+   8                           options = {},
+   7                       },
+   6                   -- your configuration comes here
+   5                   -- or leave it empty to use the default settings
+   4                   -- refer to the configuration section below
+   3                 })
+   2             end
+   1         })

```

TODO: config nvim-cmp
