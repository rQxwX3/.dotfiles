-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
	local lazyrepo = "https://github.com/folke/lazy.nvim.git"
	local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
	if vim.v.shell_error ~= 0 then
		vim.api.nvim_echo({
			{ "Failed to clone lazy.nvim:\n", "ErrorMsg" },
			{ out,                            "WarningMsg" },
			{ "\nPress any key to exit..." },
		}, true, {})
		vim.fn.getchar()
		os.exit(1)
	end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)

require("lazy").setup({
	spec = {
		{
			"folke/tokyonight.nvim",
			config = function()
				vim.cmd.colorscheme "tokyonight-night"
				vim.cmd(":hi statusline guibg=NONE")
			end
		},

		{ import = "config.plugins" },

		{
			dir = "~/floatrunner.nvim",
			name = "floatrunner",
			config = function()
				require("floatrunner").setup({
					langs = {
						{
							exts = { "c" },
							command = "gcc %s -o %s && ./%s",
							argv = { "%.", "%", "%" }
						},
						{
							exts = { "cpp" },
							command = "g++ -std=c++20 -Wall -Wextra -Werror %s && ./a.out",
							argv = { "%." }
						},
						{
							exts = { "py" },
							command = "python3 %s",
							argv = { "%." }
						},
					},

					builds = {
						["Makefile"] = "make"
					},

					maps = {
						floaterm_on = "<leader>tt",
						floaterm_off = "<esc><esc>",
						floatrun = "<leader>fr",
						floatbuild = "<leader>fb"
					}
				})
			end
		}
	},
})
