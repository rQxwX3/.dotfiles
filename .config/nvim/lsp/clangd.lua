return {
	cmd = { 'clangd', '--background-index', '--fallback-style=none', '--clang-tidy' },
	root_markers = { 'compile_commands.json', 'compile_flags.txt' },
	root_dir = require('lspconfig.util').root_pattern('compile_commands.json', '.clang-format'),
	filetypes = { 'c', 'cpp' },
}
