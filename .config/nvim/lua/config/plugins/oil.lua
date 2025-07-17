return {
	{
		'stevearc/oil.nvim',
		---@module 'oil'
		---@type oil.SetupOpts
		opts = {},
		dependencies = { { "echasnovski/mini.icons", opts = {} } },

		config = function(_, opts)
			require("oil").setup(opts)
			vim.keymap.set("n", "<leader>oo", "<CMD>Oil<CR>")
		end,
	}
}
