return {
	"akinsho/toggleterm.nvim",
	version = "*",
	keys = {
		{ "<C-t>", desc = "Toggle terminal" },
		{ "<leader>t1", desc = "Terminal 1" },
		{ "<leader>t2", desc = "Terminal 2" },
		{ "<leader>t3", desc = "Terminal 3" },
		{ "<leader>t4", desc = "Terminal 4" },
		{ "<leader>t5", desc = "Terminal 5" },
		{ "<leader>t6", desc = "Terminal 6" },
	},
	opts = {
		size = function(term)
			if term.direction == "horizontal" then
				return 15
			elseif term.direction == "vertical" then
				return vim.o.columns * 0.4
			end
		end,
		hide_numbers = true,
		shade_terminals = true,
		start_in_insert = true,
		persist_size = true,
		persist_mode = false,
		close_on_exit = true,
		direction = "horizontal",
	},
	config = function(_, opts)
		require("toggleterm").setup(opts)

		local Terminal = require("toggleterm.terminal").Terminal

		vim.keymap.set({ "n", "t" }, "<C-t>", function()
			require("toggleterm").toggle(0, nil, nil, "horizontal")
		end, { desc = "Toggle terminal" })

		for i = 1, 6 do
			vim.keymap.set("n", "<leader>t" .. i, function()
				require("toggleterm").toggle(i, nil, nil, "horizontal")
			end, { desc = "Toggle terminal " .. i })
		end

		-- switch terminals from terminal mode with <A-1> through <A-6>
		for i = 1, 6 do
			vim.keymap.set("t", "<A-" .. i .. ">", function()
				vim.cmd("stopinsert")
				local cur = vim.b.toggle_number
				if cur then
					require("toggleterm").toggle(cur, nil, nil, "horizontal")
				end
				vim.schedule(function()
					require("toggleterm").toggle(i, nil, nil, "horizontal")
				end)
			end, { desc = "Switch to terminal " .. i })
		end

		vim.keymap.set("n", "<leader>ta", "<cmd>ToggleTermToggleAll<CR>", { desc = "Toggle all terminals" })

		local lazygit = Terminal:new({
			cmd = "lazygit",
			direction = "float",
			hidden = true,
			float_opts = { border = "curved" },
		})
		vim.keymap.set("n", "<leader>gg", function()
			lazygit:toggle()
		end, { desc = "Toggle lazygit" })
	end,
}
