return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	---@type snacks.Config
	opts = {
		picker = {
			ui_select = true,

			sources = {
				grep = {
					exclude = {
						"lazy-lock.json",
						"go.mod",
						"go.sum",
						"pnpm-lock.yaml",
						"yarn.lock",
						"package-lock.json",
						"package.json",
						"Cargo.lock",
					},
				},
				files = {
					exclude = {
						"lazy-lock.json",
						"go.sum",
						"pnpm-lock.yaml",
						"yarn.lock",
						"package-lock.json",
						"Cargo.lock",
					},
				},
				explorer = {
					layout = { preset = "sidebar", hidden = { "input" } },
					win = {
						list = {
							keys = {
								["a"] = false, -- add
								["d"] = false, -- delete
								["c"] = false, -- copy
								["m"] = false, -- move
								["o"] = false, -- open with system app
								["p"] = false, -- paste
								["y"] = false, -- yank
								-- keep navigation + toggle
								["<CR>"] = "confirm",
								["."] = "explorer_focus",
								[","] = "explorer_up",
								["t"] = "confirm",
								["h"] = "toggle_hidden",
								["i"] = "toggle_ignored",
								["z"] = "explorer_close_all",
								["r"] = "explorer_update",
							},
						},
					},
				},
			},
		},
		explorer = {
			replace_netrw = false,
		},
		words = { enabled = true },
		quickfile = { enabled = true },
	},
	keys = {
		{
			"<leader>,",
			function()
				Snacks.explorer()
			end,
			desc = "File Explorer",
		},
		{
			"<leader>/",
			function()
				Snacks.picker.grep()
			end,
			desc = "Grep",
		},
		{
			"<leader>f",
			function()
				Snacks.picker.files()
			end,
			desc = "Find Files",
		},
		{
			"<leader>sh",
			function()
				Snacks.picker.help()
			end,
			desc = "Help Pages",
		},
		{
			"<leader>ss",
			function()
				Snacks.picker.lsp_symbols()
			end,
			desc = "LSP Symbols",
		},
		{
			"<leader>sS",
			function()
				Snacks.picker.lsp_workspace_symbols()
			end,
			desc = "Workspace Symbols",
		},
		{
			"<leader>su",
			function()
				Snacks.picker.undo()
			end,
			desc = "Undo History",
		},
		{
			"<leader>st",
			function()
				---@diagnostic disable-next-line: undefined-field
				Snacks.picker.todo_comments({ keywords = { "TODO", "FIX", "FIXME" } })
			end,
			desc = "Todo/Fix/Fixme",
		},
		-- LSP
		{
			"gd",
			function()
				Snacks.picker.lsp_definitions()
			end,
			desc = "Goto Definition",
		},
		{
			"gD",
			function()
				Snacks.picker.lsp_declarations()
			end,
			desc = "Goto Declaration",
		},
		{
			"gr",
			function()
				Snacks.picker.lsp_references()
			end,
			nowait = true,
			desc = "References",
		},
		{
			"gI",
			function()
				Snacks.picker.lsp_implementations()
			end,
			desc = "Goto Implementation",
		},
		{
			"gy",
			function()
				Snacks.picker.lsp_type_definitions()
			end,
			desc = "Goto Type Definition",
		},
		{
			"]]",
			function()
				Snacks.words.jump(vim.v.count1)
			end,
			desc = "Next word reference",
		},
		{
			"[[",
			function()
				Snacks.words.jump(-vim.v.count1)
			end,
			desc = "Previous word reference",
		},
	},
}
