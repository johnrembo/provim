-- import x-ray/navigator safely
local nav_status, nav = pcall(require, "navigator")
if not nav_status then
	return
end

nav.setup({
	lsp = {
		disable_lsp = {
			"lua_ls",
            "phpactor",
			"intelephense",
		},
	},
})
