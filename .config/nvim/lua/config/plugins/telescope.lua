return {
	{
		'nvim-telescope/telescope.nvim',
		tag = '0.1.8',
		dependencies = {
			'nvim-lua/plenary.nvim',
			{
				'nvim-telescope/telescope-fzf-native.nvim',
				build = 'make'
			},
		},
		config = function()
			require('telescope').setup {
				extensions = {
					fzf = {},
					zoxide = {
						mappings = {
							default = {
								after_action = function()
									vim.cmd("Telescope find_files")
								end,
							},
						}, },
				}
			}

			require('telescope').load_extension('fzf')
			require("telescope").load_extension('zoxide')

			vim.keymap.set("n", "<leader>fh", require('telescope.builtin').help_tags)
			vim.keymap.set("n", "<leader>fd", require('telescope.builtin').find_files)
			vim.keymap.set("n", "<leader>lg", require('telescope.builtin').live_grep)

			vim.keymap.set("n", "<leader>lsp", function()
				require('telescope.builtin').diagnostics {
					bufnr = 0
				}
			end)

			vim.keymap.set("n", "<leader>en", function()
				require('telescope.builtin').find_files {
					cwd = vim.fn.stdpath("config")
				}
			end)
		end
	},
	{
		'jvgrootveld/telescope-zoxide',
		config = function()
			vim.keymap.set("n", "<leader>zl", function()
				require('telescope').extensions.zoxide.list()
			end)
		end
	},
}
