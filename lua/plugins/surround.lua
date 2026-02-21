return {
	"kylechui/nvim-surround",
	init = function()
		vim.g.nvim_surround_no_mappings = true
	end,
	event = "VeryLazy",
	config = function()
		require("nvim-surround").setup()

		vim.keymap.set("n", "s", "<Plug>(nvim-surround-normal)", { desc = "Surround" })
		vim.keymap.set("n", "ss", "<Plug>(nvim-surround-normal-cur)", { desc = "Surround line" })
		vim.keymap.set("x", "s", "<Plug>(nvim-surround-visual)", { desc = "Surround selection" })
		vim.keymap.set("n", "ds", "<Plug>(nvim-surround-delete)", { desc = "Delete surround" })
		vim.keymap.set("n", "cs", "<Plug>(nvim-surround-change)", { desc = "Change surround" })
	end,
}
