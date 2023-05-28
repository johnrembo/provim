local opt = vim.opt

-- toggle paste mode
opt.pastetoggle = "<F2>"

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
--opt.undodir = vim.fn.expand("~/.vim/undo/") -- keep undo files out of file dir
--opt.directory = vim.fn.expand("~/.vim/swp/") -- keep unsaved changes away from file dir
--opt.backupdir = vim.fn.expand("~/.vim/backup/") -- backups also should not go to git
