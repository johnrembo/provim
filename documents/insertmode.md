Про Vim " Режим вставки

В [предыдущем посте про горячие клавиши](https://habr.com/ru/post/706402/) был сделан вывод о том, что лучше не трогать родные горячие клавиши и сочетания с модификатором `CTRL` и освоить их как есть, а все пользовательские команды и управление плагинами оставить на сочетания с клавишей лидером. Их туда можно напихать можно сколько угодно. Мнемонически это выгодно тем что базовые сочетания будут работать везде и вы знаете, что сочетания с лидером могу работать каждый раз немного по-разному, особенно если вы активно используете конфигурации под определенные типы файлов (`:filetype on`). В каком-то случае LSP (Language Server Protocol) нужен, в каком-то нет, где-то DAP (Debug Adapter Protocol) работает, где-то в нем нет смысла, для большинства типов файлов омни автодополнение включено, для SQL скриптов лучше вызывать его вручную и так далее.

Однако всё это хозяйство работает пока не включен режим вставки. В режиме вставки остается очень ограниченный перечень плюшек, работающих с нажатым `CTRL`. Большинство пользователей при этом дружно сходятся во мнении, что в данном случае нужно беспрекословно следовать той самой философии "модального" режима, а именно: режим вставки - только для вставки. То есть встали на нужное место, нажали один из вариантов входа в режим вставки, кстати их там вагон и маленькая тележка, набрали нужный кусочек текста, и тут же вернулись в нормальный режим. Нормальный он, кстати именно поэтому - другие режимы считаются "ненормальными". Так вот к этой философии привыкнуть после пары десятков лет с WYSWIG с разбегу, прямо скажем, сложновато.

Ну, во-первых, нужно именно сломать в голове парадигму, что режим вставки это то в каком состоянии должен быть редактор большую часть времени. Особенно сложно с этим свыкнуться при наборе вот такого текста из головы, когда вы работаете не какими-то дискретными отрезками, как, например, при рефакторинге программ, а довольно длинными сессиями, когда нужно изложить цельную мысль, не теряя её посередине. Должны ли быть здесь паузы после каждого предложения или абзаца? Надо ли выходить в нормальный режим, когда мысль закончена? Когда считать мысль законченной? Словом, не так тут всё просто. Надо ли при этом выходить в нормальный режим, когда тут же замечаешь опечатку, пропущенную запятую, неправильный регистр? Всё-таки кажется логичнее тут же на месте вернуться на пару слов назад, исправить, и продолжить редактирование без переключения в голове способа передвижения. Может это сложно только в начале, и я просто сам еще не привык это делать на уровне условного рефлекса, но что-то мне подсказывает, что средний человек, всё-таки сталкивается с похожей проблемой. Ну, конечно, если согласиться с тем, что я сам некий средний товарищ. Сколько длится этот переходный период? Месяц? Год? До тех пор пока человек не плюнет на всё это? 

Поэтому и еще по паре причин ниже, предлагаю остановиться, опять же, на некоем промежуточном варианте, тем более, что Vim такую возможность из коробки, оказывается, предоставляет.

# Motions

Мне почему-то не сразу попало в поле зрения сочетание `<C-o>`, которое как-раз реализует эту промежуточную парадигму, когда режим вставки более нормален, чем нормальный режим. Сочетание в режиме вставки кастануть ровно одно заклинание из нормального режима и продолжить. Например, вы забыли запятую три слова назад: что бы вернуться и вставить запятую каноничным способом вам надо выйти из режима вставки, вернуться на три слова назад обычным способом, войти в режим вставки в конец строки - `<Esc>3bhi,<Esc><A>` (или, скажем, `\'3F<Space>i,\'A`, как бы сделал я). Либо, считая режим вставки "приоритетным" в данный момент можно поступить более интуитивно: `<C-o>3F<Space>,<C-o>$`. Кажется, что движений потребовалось почти одинаковое количество, однако, мне крайней мере кажется, что чуть более быстрый способ, при этом чуть менее мысленно сложный - вы в каждый момент времени всё-таки в одном режиме работы. Либо же, для такого случая, я все-же пока чаще пользуюсь стрелками.

Вот честно не знаю, насколько использование стрелок в режиме редактирования православно с точки зрения замысла Vim. Вроде как исконно Vim задумывался именно для клавиатур без стрелок передвижения курсора. Есть масса высказываний на тему, что для начинающего пользователя вообще лучше выключить стрелки (да и прочие кнопки справа от Enter) на уровне системы. Так сказать, что бы максимально погрузиться в новую (старую) философию. Но, лично мне, вся эта история с ноутбучными и минималистскими клавиатурами не очень близка. (Далека скорее. Может когда-нибудь...). Но раз они есть, то почему бы ими и не пользоваться?

В режиме вставки прекрасно со своей функцией справляются сочетания `CTRL` стрелками, да и просто сами стрелки. Тем более что я часто не попадаю по количеству слов в заданный пробел, а еще чаще нужно остановиться по-середине слова что бы исправить опечатку, причем последнего слова. Куда же тут без стрелок? Выходить в нормальны режим делать `hhhhh`, `cl`... `<Esc>A` довольно утомительно, не считаете? Отпишитесь пожалуйста если знаете способ лучше, действительно очень интересно. То же самое можно сказать про `HOME`, `END`. Надо понимать, что речь тут именно про редактирование обыкновенных текстов: статеек, документации, может быть даже длинных запросов и блоков кода, которые можно записать разом. Разумеется, когда при написании программ нужно активно лазить не столько по строке сколько вверх-вниз по коду, то тут безусловно удобнее выходить в нормальный режим. И то, знаете, не всегда.

Пример классический: надо что-то вертикальное (список полей) расположить в строку, или наоборот сперва разложить список на строки, и, не знаю, добавить по запятой спереди или сзади. И важно, что элементов в списке не 29, а скажем три. Не прибегать же каждый раз к регуляркам или к макросам? Есть еще, конечно, блочный режим (`<C-v>`...`I`...), о котором мне сразу напомнят более продвинуты товарищи, но, я к нему никак пока не могу привыкнуть, потому что, наверное, нужен он не так часто как. Но вот с точки зрения, опять же, того что бы не терять мысль во время набора кода, не отвлекаясь на дополнительные сущности, мне иногда проще вот так быстренько пробежаться курсором и вставить эти злосчастные запятые. Если я вижу, что на такой топорный способ уйдет значительно больше времени, чем сказать себе: "подождите, тут же можно применить макрос" или "все строки повторяются с одного и того же символа", или "все числа выровнены в один вертикальный блок", то да, можно даже слазить в интернет, и посмотреть как же там было делать инкремент.

Тем более, что стрелки работают так как надо без каких бы то ни было предварительных ласк. Кроме случаев, когда они конфликтуют с эмулятором терминала или системы. Например, с tmux пришлось немного повозиться: дать ему в `.tmux.conf`

```
set-window-option -g xterm-keys on
```

А так же добавить немного черной магии в `.vimrc`:

```
" tmux compatibility
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

if &term =~ '^screen'
    " tmux will send xterm-style keys when its xterm-keys option is on
    execute "set <xUp>=\e[1;*A"
    execute "set <xDown>=\e[1;*B"
    execute "set <xRight>=\e[1;*C"
    execute "set <xLeft>=\e[1;*D"
endif
```
Что конкретно это означает, к сожалению, я вам сказать не могу, но это работает.

В общем, тут я готов принять критику, что это не очень каноничный подход, и посыпать голову пеплом, но вот в ситуации, когда использование стрелок не вызывает у вас аллергический приступ, то и не надо искать сложных путей и как будто бы всё хорошо. Однако, есть ситуация в которой, из которой кажется выхода нет совсем. Или я его еще не нашел. (А может и не надо его искать?)

# Soft wrap

Короче, это случай с набором строк длиннее чем количество символов по горизонтали. Опять же, этот случай имеет свою определенную нишу, а именно, набор текста на естественном языке, как, например, этот. По умолчанию, как-будто, считается, что Vim не совсем предназначен для такого сценария использования. Да, есть у нас в распоряжении `:set wrap linebreak`, но он работает в режиме вставки, мягко сказать, не совсем так как от него ожидаешь. То есть длинная строка это всё-таки всё еще одна длинная строка, но просто отображается как несколько. И это как-будто бы даже логично, но, увы, перемещение по такой строке вызывает другие логические вопросы. Хочется всё-же вверх вниз двигаться по ней так, как она состояла бы из нескольких отдельных строк.

Есть радикальное решение. Использовать жесткие переносы: `:set texwidth=80`. Однако, понятно, что с этим появляются другие проблемы. Такой текст нельзя скопировать уже в какой-то другой редактор без переводов строки. Не понятно при этом 80 ли? Может где-то этого мало, может наоборот. Что вы будете делать, когда окну в данный момент доступно меньше столбцов? Если наоборот вам почти всегда доступно 120 и более? Если вы не пишите ничего кроме коротеньких программ на условном питоне, то в принципе это может быть решением. В почти всех других случаях, когда ваш язык программирования более многословен, когда это SQL запросы, когда нужна развернутая документация, то такой выход скорее полумера.

Допускаю, что можно сделать так, что при выделении или копировании или по какому-то специальному сигналу, типа `gq`, можно как-то повлиять на ситуацию, но выглядит это, как по мне, так скорее как костыль.

С мягким переносом обозначенные проблемы исчезают, но появляются свои. Параграф естественного текста это фактически одна длинная строка. А параграфы бывают длинные (теоретически бесконечные). Перемещаться по нему вверх вниз в режиме вставки у меня не получается никак. Уж сколько я искал, всё сводится к одному: выйти в нормальный режим, а там уже вариантов множество. Один из них - сделать парочку переназначений.

```
" move between soft wrapped lines
nnoremap <expr> j v:count ? 'j' : 'gj'
nnoremap <expr> k v:count ? 'k' : 'gk'
nnoremap <expr> <Down> v:count ? 'j' : 'gj'
nnoremap <expr> <Up> v:count ? 'k' : 'gk'
```

Выглядит хитрее стандартного назначения, но тут на самом деле использованы лямбды. В данном случае `<expr>` делает доступной в правой части выражения переменную `v`, к которой можно применить методы, и, как здесь, обычный тернарный оператор. В Lua такое заклинание выглядит чуть более понятно:

```
-- soft wrap remap
local expr_opts = { noremap = true, expr = true, silent = true }
vim.keymap.set({ "n", "v" }, "j", "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set({ "n", "v" }, "k", "v:count == 0 ? 'gk' : 'k'", expr_opts)
vim.keymap.set({ "n", "v" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", expr_opts)
vim.keymap.set({ "n", "v" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", expr_opts)
```

Где за передачу параметра отвечает `expr=true`. И, да, я наверное, в следующий раз объясню зачем мне делать конфигурацию одновременно на Vim и NeoVim. И файлы выложить тогда же - в этот раз опять не получается собраться.

Это я отвлекся. Так вот этого, к сожалению, не достаточно. Потому что оно, как и было обозначено ранее, не работает в режиме вставки. То есть либо надо всё-время переключаться, либо считать в бок слова или знаки, с чем лично у меня, есть проблемы. В пределах 5 слов, наверное, можно как-то быстро ориентироваться. В пределах параграфа в дюжину строчек, думаю, ни у какого нормального человека не хватит вычислительной мощности мозга что бы хотя бы примерно перескочить назад на несколько строчек.

Есть, говорят, плагины, которые, снова, частично, но хоть как-то облегчают жизнь. Например, как вот этот [easymotion/vim-easymotion](https://github.com/easymotion/vim-easymotion). Он у меня установлен, но, честно сказать, пока я им не пользуюсь совсем, хотя и чувствую - зря. Опять же, он работает в нормальном режиме, но используя тактику с сочетание `<C-o>` в режиме вставки, думаю можно добиться определенной степени ловкости, что бы не замечать боль связанную с невозможностью перемещения стрелками по перенесенному параграфу вверх вниз.

# Registers

Примерно такую же функцию как `<C-o>` в режиме вставки выполняет `<C-r>`, только с регистрами, позволяя буквально впечатывать текст из регистра (так мы теперь называем буфер обмена). Тут важно понимать, что это именно впечатывание, что чуть отличается от вставки. Потому что если в регистре содержатся управляющие последовательности, то они выполнятся так, как будто по вы вводите содержимое с клавиатуры. Что иногда мешает, а иногда наоборот приходится кстати. Именно поэтому в предыдущей статье было предложено поставить переключатель режима вставки.

```
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>
```

Который временно переключает поведение вставки так как она работала бы в нормальном режиме. То есть, в большинстве случаев, особенно когда дело касается исходного кода программ, изобилующим разного рода символами и отступами, вам либо надо покинуть режим вставки, либо вот так переключить режим в дополнительный. (Который при этом за одно почему-то отключает `<C-^>`, который в свою очередь переключает раскладку. Поэтому включенным постоянно его держать не выйдет).

Еще один бонус использования регистров так, как это задумано в Vim это то, что сочетание `<C-r>` работает и в других режимах кроме нормального - в командном, в терминальном. Нет сомнений и в том, что их, этих регистров, мало того что несколько встроенных, можно самостоятельно привязать их к буквам. Правда, я пока не достиг того уровня дзена, когда я помню что у меня лежит кроме как в системном (+) и в родном (") регистрах. Существуют способы и плагины сделать работу с регистрами более интуитивной и наглядной, но мне пока хватает стандартной `:reg`.

Кстати, может у вас есть способ наоборот использовать регистры Vim за его пределами? Сторонний софт, который бы давал возможность вставлять регистры во внешние программы?

Это, пожалуй, всё что я хотел сегодня сказать конкретно про режим вставки. Есть еще пару нюансов связанных с режимом вставки. В частности, работа с автодополнением (или как правильно по-русски это называется, подскажите) и с проверкой правописания, но этих моментов правильнее будет коснуться в связанных выпусках рубрики. А в следующий раз, я хочу продвинуться от эдакой предварительной подготовки почвы, сказать еще пару заключительных вещей на общие темы и перейти уже к какой-то программистской специфике и уже к более конкретным плагинам и ноу-хау.

`ZZ`
