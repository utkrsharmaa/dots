return {
	{
		"folke/tokyonight.nvim",
		priority = 1000, -- Make sure to load this before all the other start plugins.
		config = function()
			---@diagnostic disable-next-line: missing-fields
			require("tokyonight").setup({
				styles = {
					comments = { italic = false }, -- Disable italics in comments
				},
			})
		end,
	},
	{
		"nyoom-engineering/oxocarbon.nvim",
		priority = 1000,
		config = function() end,
	},
	{
		"rebelot/kanagawa.nvim",
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("kanagawa") -- SET THIS OPTION FOR THE THEME YOU WANT TO SET
		end,
	},
}
-- vim: ts=2 sts=2 sw=2 et
