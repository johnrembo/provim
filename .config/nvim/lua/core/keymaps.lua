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

