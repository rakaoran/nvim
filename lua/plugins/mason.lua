return {
	{
		"mason-org/mason-lspconfig.nvim",
		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },
			"neovim/nvim-lspconfig",
		},
		config = function(_, opts)
			require("mason-lspconfig").setup(opts)

			vim.lsp.config("lua_ls", {
				settings = {
					Lua = {
						runtime = { version = "LuaJIT" },
						workspace = {
							checkThirdParty = false,
							library = { vim.env.VIMRUNTIME },
						},
					},
				},
			})
		end,
		opts = {
			ensure_installed = {
				"lua_ls",
				"bashls",
				"buf_ls",
				"zls",
				"pyright",
				"ts_ls",
				"clangd",
				"html",
				"cssls",
				"jsonls",
				"gopls",
				"rust_analyzer",
				"tailwindcss",
			},
			automatic_enable = true,
		},
	},
}
