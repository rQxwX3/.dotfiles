-- Options
vim.o.number = true
vim.o.relativenumber = true
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.statusline = '%=%F%m%='
vim.o.clipboard = 'unnamedplus'
vim.o.signcolumn = 'yes:1'
--vim.o.colorcolumn = '80'
vim.o.showmode = false
vim.o.showcmd = false
vim.o.winborder = 'rounded'
vim.o.ruler = false
vim.o.cursorline = true
-- Prevent cursor in terminal from blinking
vim.o.guicursor = 'n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20'
vim.g.mapleader = ' '

-- Plugins
vim.pack.add({
	{ src = 'https://github.com/folke/tokyonight.nvim' },
	{ src = 'https://github.com/stevearc/oil.nvim' },
	{ src = 'https://github.com/kawre/neotab.nvim' },
	{ src = 'https://github.com/windwp/nvim-autopairs' },
	{ src = 'https://github.com/rQxwX3/floatrunner.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope.nvim' },
	{ src = 'https://github.com/jvgrootveld/telescope-zoxide' },
	{ src = 'https://github.com/nvim-tree/nvim-web-devicons' },
	{ src = 'https://github.com/nvim-treesitter/nvim-treesitter' },
	{ src = 'https://github.com/nvim-lua/plenary.nvim' },
	{ src = 'https://github.com/nvim-telescope/telescope-fzf-native.nvim' },
	{ src = 'https://github.com/arnamak/stay-centered.nvim' },
	{ src = 'https://github.com/chomosuke/typst-preview.nvim' },
	{
		src = 'https://github.com/saghen/blink.cmp',
		version = vim.version.range("*")
	},
})

-- Plugin configuration
require('blink.cmp').setup({
	signature = { enabled = true }
})
require 'stay-centered'.setup {}
require 'nvim-autopairs'.setup {}
require 'neotab'.setup {}
require 'oil'.setup {}
require 'nvim-treesitter.configs'.setup({
	ensure_installed = { 'c', 'cpp', 'lua', 'java', 'javascript', 'python', 'rust' },
	highlight = { enabled = true },
	auto_install = true,
})
require 'floatrunner'.setup {
	langs = {
		{ exts = { 'c' }, argv = { '%.' }, command = 'gcc %s && ./a.out' },
		{
			exts = { 'cpp' }, argv = { '%.' },
			command = 'clang++ %s -std=c++23 -Wall -Wextra -Werror && ./a.out'
		}
	},

	builds = { ['Makefile'] = 'make' }
}
require('telescope').setup({
	defaults = {
		file_ignore_patterns = {
			"build",
			"CMakeFiles",
			"cmake",
		},
	},
	extensions = {
		fzf = {},
		zoxide = {
			mappings = {
				default = {
					after_action = function()
						vim.cmd('Telescope find_files')
					end,
				},
			},
		},
	}
})
require('telescope').load_extension('fzf')
require('telescope').load_extension('zoxide')
require('typst-preview').setup({})

-- Commands
vim.cmd('colorscheme tokyonight-night')
vim.cmd('hi statusline guibg=NONE')
vim.cmd('hi statuslineNC guibg=NONE') -- inactive window

-- Keymaps
vim.keymap.set('n', '<leader>oo', ':Oil<CR>')

vim.keymap.set('n', '<leader>h', function()
	vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled());
end)

vim.keymap.set('n', '<leader>tt', function() vim.cmd('FloatRunner toggle') end)
vim.keymap.set('t', '<esc><esc>', function() vim.cmd('FloatRunner toggle') end)
vim.keymap.set('n', '<leader>fr', function() vim.cmd('FloatRunner run') end)
vim.keymap.set('n', '<leader>fb', function() vim.cmd('FloatRunner build') end)

vim.keymap.set('n', 'j', 'gj', { noremap = true });
vim.keymap.set('n', 'k', 'gk', { noremap = true });

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>fd', builtin.find_files)
vim.keymap.set('n', '<leader>lg', builtin.live_grep)
vim.keymap.set('n', '<leader>bb', builtin.buffers)
vim.keymap.set('n', '<leader>fh', builtin.help_tags)
vim.keymap.set('n', '<leader>lsp', function()
	builtin.diagnostics({ bufnr = 0 })
end)

vim.keymap.set('n', '<leader>en', function()
	builtin.find_files({
		cwd = vim.fn.stdpath('config'), prompt_title = 'Neovim config'
	})
end)

vim.keymap.set('n', '<leader>zl', function()
	require('telescope').extensions.zoxide.list()
end)

-- Autocommands
vim.api.nvim_create_autocmd('TextYankPost', {
	callback = function() vim.hl.on_yank() end
})

vim.api.nvim_create_autocmd({ 'InsertLeave', 'TextChanged' }, {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0)
		if bufname ~= '' and vim.bo.modifiable and
			vim.bo.buflisted and not vim.bo.readonly then
			vim.cmd "silent w"
		end
	end,
})

vim.api.nvim_create_autocmd('FileType', {
	pattern = 'cpp',

	callback = function()
		vim.bo.expandtab = true
	end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
	pattern = 'COMMIT_EDITMSG',

	callback = function()
		vim.bo.textwidth = 72
		vim.bo.formatoptions = vim.bo.formatoptions .. 't'
	end,
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if not client then return end

		if not client:supports_method('textDocument/willSaveWaitUntil')
			and client:supports_method('textDocument/formatting') then
			vim.api.nvim_create_autocmd('BufWritePre', {
				buffer = args.buf,
				callback = function()
					vim.lsp.buf.format({ bufnr = args.buf, id = client.id })
				end,
			})
		end
	end,
})

-- Highlight
vim.api.nvim_set_hl(0, 'TelescopeNormal', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopeBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopePromptTitle', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopePromptBorder', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopePreviewTitle', { bg = 'none' })
vim.api.nvim_set_hl(0, 'TelescopeResultsTitle', { bg = 'none' })

-- LSP
vim.lsp.enable({ 'lua_ls', 'clangd', 'tinymist' })
