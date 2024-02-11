vim.g.vim_php_refactoring_use_default_mapping = 0

local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local vopts = {
	mode = "v", -- VISUAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local mappings = {
	l = {
		name = "PHP",
		r = {
			name = "Refactor",
			v = { "<cmd>call PhpRenameLocalVariable()<cr>", "Rename local variable" },
			V = { "<cmd>call PhpRenameClassVariable()<cr>", "Rename class variable" },
			m = { "<cmd>call PhpRenameMethod()<cr>", "Rename method" },
			u = { "<cmd>call PhpDetectUnusedUseStatements()<cr>", "Detect obsolete use" },
			["="] = { "<cmd>call PhpAlignAssigns()", "Align assigns" },
		},
		e = {
			name = "Extract",
			u = { "<cmd>:call PhpExtractUse()<cr>", "Extract use" },
			p = { "<cmd>:call PhpExtractClassProperty()<cr>", "Extract const" },
		},
		c = {
			name = "Create",
			p = { "<cmd>:call PhpCreateProperty()<cr>", "Create property" },
			s = { "<cmd>:call PhpCreateSettersAndGetters()<cr>", "Create setters and getters" },
			g = { "<cmd>:call PhpCreateGetters()<cr>", "Create getters" },
		},
	},
}

local vmappings = {
	l = {
		name = "PHP",
		["="] = { "<cmd>call PhpAlignAssigns()", "Align assigns" },
		r = {
			name = "Refactor",
		},
		e = {
			name = "Extract",
			c = { "<cmd>:call PhpExtractConst()<cr>", "Extract const" },
			m = { "<cmd>:call PhpExtractMethod()<cr>", "Extract method" },
		},
	},
}

which_key.register(mappings, opts)
which_key.register(vmappings, vopts)
