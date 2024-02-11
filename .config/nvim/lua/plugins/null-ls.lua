-- import null-ls plugin safely
local setup, null_ls = pcall(require, "null-ls")
if not setup then
	return
end

-- for conciseness
local formatting = null_ls.builtins.formatting -- to setup formatters
local diagnostics = null_ls.builtins.diagnostics -- to setup linters


null_ls.setup({
	sources = {
		formatting.stylua,
		formatting.google_java_format,
		diagnostics.eslint,
        formatting.phpcsfixer.with({
            command = "./tools/php-cs-fixer/vendor/bin/php-cs-fixer"
        }),
	},
	timeout = 100000,
	timeout_ms = 100000,
	debug = false,
})
