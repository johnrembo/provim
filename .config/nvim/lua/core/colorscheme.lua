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
