# Про Vim " Миграция на Neovim (Lua)

## Введение

Теоретически если вы решили пересесть с классического Vim на более современный его клон - Neovim - вам делать ничего особенного не надо. В файле `~/.config/nvim/init.vim` прописать `source ~/.vimrc` ну и скачать или скопировать словари. Идея в том, что Neovim должен поддерживать все конфигурации по умолчанию. Однако, если у вас установлено множество плагинов и разных к ним расширений, то с высокой вероятностью конфигурация загрузится с ошибками, предупреждениями и другими, не очень желательными нюансами. Да и вообще вся фишка, вся разница Neovim заключается в том, что он поддерживает настройки и плагины написанные на Lua вместо vimscript.

Lua - более современный интерпретируемый язык, на нем удобнее писать, его проще читать. А главное, считается, что работает интерпретатор на порядок быстрее родного языка. На счет порядка я бы засомневался, но действительно тяжелые плагины работают вроде как расторопнее и глаже. Впрочем и классический Vim известен не тем, что он медленный или глючный, так что тут спор скорее софистический. А вот с первыми тремя утверждениями я абсолютно согласен.

Более того для Neovim именно на Lua в последнее время выбор современных плагинов и расширений, что уж тут говорить, куда богаче. Вопрос даже не в том лучше ли эти современные аналоги, а в скорее в свежести, динамике развития и в целом в оптимизме сообщества. Очень похоже на то, что не сегодня так завтра Neovim повторит судьбу предшественника и займет свое место в распространенных дистрибутивах Linux в качестве стандартной замены устаревшему Vim. Заменит полностью? Ну, я бы не был так категоричен в этом вопросе, но вероятность такая существует.

С другой стороны, в философии Neovim нет вот этого старого аскетизма и предполагаемой сверхнадежности. Для работы в монопольном режиме в консоли сетевого устройства всё-таки наличие альтернативы не предполагается. И разработчики всё-таки рассчитывают подспудно на некий девайс на котором можно обнаружить как комплект современных сред исполнения, так и подключение к интернету. Таким образом для настройки Neovim не стоит задача сохранить работоспособность в урезанном и минмалистском окружении.

В связи с этим в сети нынче найдется дюжина, не меньше, качественных сборных солянок - готовых настроек, установив которые вы из коробки получаете комбайн готовый к большинству сценариев использования. По сути это такие отдельные продукты с собственными брендами, со своим сообществом фанатов и постоянных пользователей. И если вы не любитель самостоятельно копаться в тонких настройках программ, то один из брендов скорее всего вам подойдет на 90%.

Однако, как вы понимаете, я отношусь к тем гражданам, которым остальные 10% нужны так что спасу нет. И если вы один из таких людей, которые готовы научить Neovim чему-то очень личному или нестандартному, то остальная часть статьи именно для вас.

## Сброс

Поскольку изложенный материал это такой эксперимент над собой, о том насколько имеет смысл пройти весь путь от голого редактора до полноценной IDE, то я поступлю просто - начну с нуля. Карта того в каком направлении идти у меня уже есть - я просто повторю весь путь сделанный с оригинальным vimscript, но теперь под Lua.

Перед сбросом, однако, нужно немного подготовиться. Во-первых, я должен прикрепить список статей посвященных Vim.

[Вводные к циклу](https://habr.com/ru/articles/706402/)

[Горячие клавиши](https://habr.com/ru/articles/707416/)

[Режим вставки](https://habr.com/ru/articles/707524/)

[Файлы и плагины](https://habr.com/ru/articles/712048/)

[Встроенное](https://habr.com/ru/articles/713510/)

[Клиент БД](https://habr.com/ru/articles/714926/)

[Форматирование](https://habr.com/ru/articles/716268/)

[PHP LSP](https://habr.com/ru/articles/720522/)

[JDT LS](https://habr.com/ru/articles/723282/)

Во-вторых, я добавлю в окружение, которое я выкладываю в GitHub настройки привычных мне инструментов - tmux, zsh + oh-my-zh, какие-то алиасы. Там в принципе почти всё стандартно, так что можете смело качать и их.

[Pro Vim dotfiles](https://github.com/johnrembo/provim)

В-третьих, надо оговориться, что подход к упорядочению конфигураций в Lua сильно отличается от подхода в vimscript. Тут всё по классике: модули, иерархия, вложенность. То есть сразу отказываемся от линейной структуры и раскладываем всё по полочкам.

Главным файлом - точкой входа при этом является `~/.config/nvim/init.lua`. Создаем таковой если его нет и удаляем предыдущий `~/.config/nvim/lua/init.vim`, если он у вас был.

## Основные настройки

Чтобы в будущем было проще управлять настройками рекомендуется поместить их в специальную директорию `lua` и развести основные настройки и настройки плагинов по разным директориям.

```
$ cd ~/.config/nvim
$ mkdir lua
$ mkdir lua/core lua/plugins
```

Можно разделить по смыслу и основные настройки по неким категориям.

```
$ cd lua/core
$ touch options.lua keymaps.lua colorscheme.lua
```

Это я у кого-то взял. Так делать вовсе необязательно, но выглядит разумно. Далее просто вставляем в '~/.config/init.lua' (далее я буду ссылаться на него как к "главному файлу") ссылки на эти файлы согласно синтаксиса и парадигмы Lua, где точки в строках интерпретируются как директории а в конце добавляется расширение `.lua`. 


```
require("core.options")
require("core.keymaps")
require("core.colorscheme")

```

Для программистов надо отметить, что синтаксис у Lua достаточно своеобразный и очень вариабельный, можно что-то одно делать десятью разными способами. Что иногда напрягает, когда что-то просто отказывается работать без видимой причины. А иногда помогает, когда что-то работает несмотря на небольшие опечатки. Скажем так, еще более либеральный JavaScript. Каждый файл при этом представляет из себя не макрос, а функцию с результатом исполнения. Для тех кому не чужд vimscript можно почитать [здесь](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/) о том как быстро найти общий язык с Lua.

### Options

В первую очередь я перенесу глобальные настройки в `options.lua`, так что бы дальше работать не в голом редакторе.

```
local opt = vim.opt

-- line number
opt.relativenumber = true
opt.number = true

-- tabs & indentation
opt.tabstop = 4 -- 4 spaces for tabs (prettier default)
opt.shiftwidth = 4 -- 4 spaces for indent width
opt.expandtab = true -- expand tab to spaces
opt.autoindent = true -- copy indent from current line when starting new one

-- line wrapping
opt.wrap = true -- disable line wrapping
opt.linebreak = true

-- search settings
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true -- if you include mixed case in your search, assumes you want case-sensitive

-- cursor line
opt.cursorline = true -- highlight the current cursor line

-- appearance

-- turn on termguicolors for nightfly colorscheme to work
-- (have to use iterm2 or any other true color terminal)
opt.termguicolors = true
opt.background = "dark" -- colorschemes that can be light or dark will be made dark
opt.signcolumn = "yes" -- show sign column so that text doesn't shift

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard:append("unnamedplus") -- use system clipboard as default register

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

opt.iskeyword:append("-") -- consider string-string as whole word

-- spelling
opt.spelllang = { "en_us", "ru" } -- Словари рус eng
opt.spell = true

-- redundancy
opt.undofile = true --  keep undo history between sessions
opt.undodir = "~/.vim/undo/" -- keep undo files out of file dir
opt.directory = "~/.vim/swp/" -- keep unsaved changes away from file dir
opt.backupdir = "~/.vim/backup/" -- backups also should not go to git
```

Пояснения к настройкам даны как в комментариях, так и в первой статье цикла. Не будем на них долго останавливаться. Добавлю лишь то что в Lua принято сокращать команды путем создания переменных псевдонимов тех или иных объектов. В данном случае это первая строчка в скрипте. А также, программистам не лишним будет понимать, что знак присвоения здесь на самом деле сокращение для функции `vim.api.nvim_win_set_option`. О чем можно прочитать в мануале, на GitHub страничке проекта [Lua-guide](https://neovim.io/doc/user/lua-guide.html).

Рестартуем. Neovim не умеет самостоятельно применять конфигурацию в текущей сессии. Есть способы, но о них возможно позже.

## Colorscheme

В файл `colorscheme.lua` положим следующее:

```
-- Color control
vim.g.sonokai_style = "andromeda"
vim.g.sonokai_better_performance = 1

vim.g.sonokai_transparent_background = 1
vim.g.sonokai_diagnostic_text_highlight = 1

-- set colorscheme with protected call
-- in case it isn't installed
local status, _ = pcall(vim.cmd, "colorscheme sonokai")
if not status then
	print("Colorscheme not found, defaulting to builtin")
    vim.cmd([[colorscheme desert]])
	return
end
```

Почему нельзя было просто выполнить установку схемы? Да можно было. Этот кусок скорее для демонстрации. Здесь показано, например, что есть вариант вызвать команду в "безопасном" режиме и обработать отсутствие соответствующей цветовой схемы. Причем второй безусловный вызов встроенной схемы `colorscheme desert` выполнен в виде родной vimscript команды. То есть, если нет альтернативы выполнить команду из Lua, то можно вот так воспользоваться синтаксисом с двумя квадратными скобками, который ко всему еще многострочный.

Надо также понимать, что это всё реально конфигурация, а не прямое выполнение команд. Здесь мы задаем что будет потом выполнено при обращении к этой функции. То есть сперва конфигурация полностью формируется, а затем выполняется при вызове `require`.

Либо можно отдельно вызвать функцию из файла командой `:luafile` или `:source`:

```
:luafile ~/.config/nvim/lua/core/colorscheme.lua
```

### Keymaps

Ну и наконец следует вернуть привычные клавосочетания.

```
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness

local cmd = vim.cmd

-- Русский язык

cmd("set keymap=russian-jcukenwin")
cmd("set iminsert=0")
cmd("set imsearch=0")

---------------------
-- General Keymaps
---------------------

-- soft wrap remap
local expr_opts = { noremap = true, expr = true, silent = true }
keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
keymap.set({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opts)
keymap.set({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opts)

-- use jk to exit insert mode
keymap.set({ "v", "i" }, "\\'", "<ESC>")
keymap.set({ "v", "i" }, "\\э", "<ESC>")

-- unbind ins toggle
keymap.set("i", "<Ins>", "<ESC>")

-- yank and paste clipboard
--keymap.set({ "n", "v", "x", "t" }, "<leader>y", '"+y')
--keymap.set({ "n", "v", "x", "t" }, "<leader>Y", '"*y')
--keymap.set({ "n", "t" }, "<leader>p", '"+p')
--keymap.set({ "n", "t" }, "<leader>P", '"*p')

-- do not yank on replace or delete
--keymap.set({ "v", "x" }, "<leader>p", '"_d"+p')
--keymap.set({ "v", "x" }, "<leader>P", '"_d"*p')
--keymap.set({ "n", "v", "x", "t" }, "<leader>d", '"_d')

-- copy default reg to/from system/mouse clipboard
keymap.set({"n", "v", "x"}, '<Leader>y', ':let @+=@"<CR>')
keymap.set({"n", "v", "x"}, '<Leader>p', ':let @"=@+<CR>')
keymap.set({"n", "v", "x"}, '<Leader>Y', ':let @*=@"<CR>')
keymap.set({"n", "v", "x"}, '<Leader>P', ':let @"=@*<CR>')


-- clear search highlights
keymap.set("n", "<leader>nh", ":nohl<CR>")

-- delete single character without copying into register
keymap.set("n", "x", '"_x')

-- increment/decrement numbers
keymap.set("n", "<leader>+", "<C-a>") -- increment
keymap.set("n", "<leader>-", "<C-x>") -- decrement

-- navigate windows
keymap.set("n", "<C-j>", "<C-w>j")
keymap.set("n", "<C-h>", "<C-w>h")
keymap.set("n", "<C-k>", "<C-w>k")
keymap.set("n", "<C-l>", "<C-w>l")

-- move out of terminal
keymap.set("t", "<C-j>", "<C-\\><C-n><C-w>j")
keymap.set("t", "<C-k>", "<C-\\><C-n><C-w>k")
keymap.set("t", "<C-h>", "<C-\\><C-n><C-w>h")
keymap.set("t", "<C-l>", "<C-\\><C-n><C-w>l")

-- move line or v-block
keymap.set("i", "<C-j>", "<Esc><cmd>m .+1<CR>==gi")
keymap.set("i", "<C-k>", "<Esc><cmd>m .-2<CR>==gi")
keymap.set("x", "J", ":m '>+1<CR>gv-gv", { noremap = true, silent = true })
keymap.set("x", "K", ":m '<-2<CR>gv-gv", { noremap = true, silent = true })

-- stay in indent mode
keymap.set("v", ">", ">gv", { noremap = true, silent = true })
keymap.set("v", "<", "<gv", { noremap = true, silent = true })

-- window management
keymap.set("n", "<leader>wv", "<C-w>v") -- split window vertically
keymap.set("n", "<leader>wh", "<C-w>s") -- split window horizontally
keymap.set("n", "<leader>we", "<C-w>=") -- make split windows equal width & height
keymap.set("n", "<leader>wx", ":close<CR>") -- close current split window

-- tabs
keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

-- buffers
keymap.set("n", "<leader>bo", ":new<CR>") -- open new tab
keymap.set("n", "<leader>bd", ":bdelete<CR>") -- close current tab
keymap.set("n", "<leader>bn", ":bn<CR>") --  go to next tab
keymap.set("n", "<leader>bp", ":bp<CR>") --  go to previous tab

-- shift arrow like gui
keymap.set("n", "<S-Up>", "v<Up>")
keymap.set("n", "<S-Down>", "v<Down>")
keymap.set("n", "<S-Left>", "v<Left>")
keymap.set("n", "<S-Right>", "v<Right>")
keymap.set("v", "<S-Up>", "<Up>")
keymap.set("v", "<S-Down>", "<Down>")
keymap.set("v", "<S-Left>", "<Left>")
keymap.set("v", "<S-Right>", "<Right>")
keymap.set("i", "<S-Up>", "<Esc>v<Up>")
keymap.set("i", "<S-Down>", "<Esc>v<Down>")
keymap.set("i", "<S-Left>", "<Esc>v<Left>")
keymap.set("i", "<S-Right>", "<Esc>v<Right>")

-- copy paste like gui
keymap.set("v", "<C-c>", '"+y<Esc>i')
keymap.set("v", "<C-x>", '"+d<Esc>i')
keymap.set("i", "<C-v>", '"+pi')
keymap.set("i", "<C-v>", '<Esc>"+pi', { noremap = true, silent = true })
keymap.set("i", "<C-z>", "<Esc>ui", { noremap = true, silent = true })
keymap.set("i", "<C-z>", "<Esc>ui", { noremap = true, silent = true })
keymap.set({ "i", "v", "x", "t" }, "<C-a>", "<C-\\><C-n>ggVG", { noremap = true, silent = true })

----------------------
-- Plugin Keybinds
----------------------

```

Здесь я намеренно оставил некоторые комментарии. В конце заготовка для сочетаний плагинов. Обратите внимание, что теперь их можно поместить в одно место, в независимости от того где и когда подключается сам плагин. Также, если обратить внимание на секцию использования регистров, то тут я отключил популярный способ работы с системным буфером обмена и привел свою находку.

Отличается этот подход тем, что мы не трогаем поведение стандартных клавиш, а дополняем их операциями перемещения регистра в буфер и обратно. Таким образом не нарушаются движения связанные с использованием клавиш `y` и `p`, а работа с внешним буфером идет как дополнительная команда. На мой вкус такой подход оказался более интуитивным, хотя добавляется еще одно незначительное действие. Также оно позволяет затем сколько угодно раз перезаписывать регистры без затирания системного буфера при вставке в несколько мест одного и того же с перезаписью.

Пожалуй на сегодня хватит. Далее плагины.
