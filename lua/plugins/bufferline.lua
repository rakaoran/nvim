return {
	"akinsho/bufferline.nvim",
	version = "*",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	lazy = false,
	opts = function()
		local colors = require("tokyonight.colors").setup({ style = "night" })
		return {
		highlights = {
			fill = { bg = colors.bg_dark },
			background = { bg = colors.bg_dark, fg = colors.comment },
			buffer_selected = { bg = colors.bg, bold = true },
			buffer_visible = { bg = colors.bg_dark, fg = colors.fg_dark },
			separator = { bg = colors.bg_dark, fg = colors.bg_dark },
			separator_selected = { bg = colors.bg, fg = colors.bg_dark },
			separator_visible = { bg = colors.bg_dark, fg = colors.bg_dark },
			numbers = { bg = colors.bg_dark, fg = colors.comment },
			numbers_selected = { bg = colors.bg, bold = true },
			numbers_visible = { bg = colors.bg_dark, fg = colors.fg_dark },
			modified = { bg = colors.bg_dark },
			modified_selected = { bg = colors.bg },
			modified_visible = { bg = colors.bg_dark },
			duplicate = { bg = colors.bg_dark, fg = colors.comment },
			duplicate_selected = { bg = colors.bg, italic = true },
			duplicate_visible = { bg = colors.bg_dark, fg = colors.comment },
			diagnostic = { bg = colors.bg_dark },
			diagnostic_selected = { bg = colors.bg },
			diagnostic_visible = { bg = colors.bg_dark },
			hint = { bg = colors.bg_dark },
			hint_selected = { bg = colors.bg },
			hint_visible = { bg = colors.bg_dark },
			warning = { bg = colors.bg_dark },
			warning_selected = { bg = colors.bg },
			warning_visible = { bg = colors.bg_dark },
			error = { bg = colors.bg_dark },
			error_selected = { bg = colors.bg },
			error_visible = { bg = colors.bg_dark },
			indicator_selected = { fg = colors.git.change, bg = colors.bg },
		},
		options = {
			numbers = "ordinal",
			close_command = "bdelete! %d",
			diagnostics = "nvim_lsp",
			diagnostics_indicator = function(count, level)
				local icon = level:match("error") and " " or " "
				return " " .. icon .. count
			end,
			always_show_bufferline = true,
			show_buffer_close_icons = false,
			show_close_icon = false,
			separator_style = "thin",
			offsets = {
				{
					filetype = "snacks_layout_box",
					text = "Explorer",
					highlight = "Directory",
					text_align = "center",
				},
			},
		},
	}
	end,
	keys = {
		{ "<leader>1", "<cmd>BufferLineGoToBuffer 1<cr>", desc = "Go to buffer 1" },
		{ "<leader>2", "<cmd>BufferLineGoToBuffer 2<cr>", desc = "Go to buffer 2" },
		{ "<leader>3", "<cmd>BufferLineGoToBuffer 3<cr>", desc = "Go to buffer 3" },
		{ "<leader>4", "<cmd>BufferLineGoToBuffer 4<cr>", desc = "Go to buffer 4" },
		{ "<leader>5", "<cmd>BufferLineGoToBuffer 5<cr>", desc = "Go to buffer 5" },
		{ "<leader>6", "<cmd>BufferLineGoToBuffer 6<cr>", desc = "Go to buffer 6" },
		{ "<leader>7", "<cmd>BufferLineGoToBuffer 7<cr>", desc = "Go to buffer 7" },
		{ "<leader>8", "<cmd>BufferLineGoToBuffer 8<cr>", desc = "Go to buffer 8" },
		{ "<leader>9", "<cmd>BufferLineGoToBuffer 9<cr>", desc = "Go to buffer 9" },
		{ "<S-h>", "<cmd>BufferLineCyclePrev<cr>", desc = "Prev buffer" },
		{ "<S-l>", "<cmd>BufferLineCycleNext<cr>", desc = "Next buffer" },
		{ "<leader>bd", "<cmd>bdelete<cr>", desc = "Delete buffer" },
		{ "<leader>bo", "<cmd>BufferLineCloseOthers<cr>", desc = "Close other buffers" },
		{ "<leader>br", "<cmd>BufferLineCloseRight<cr>", desc = "Close buffers to the right" },
		{ "<leader>bl", "<cmd>BufferLineCloseLeft<cr>", desc = "Close buffers to the left" },
	},
	config = function(_, opts)
		require("bufferline").setup(opts)

		-- LRU: auto-close least recently used buffers when exceeding 10
		local max_buffers = 6
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("bufferline-lru", { clear = true }),
			callback = function()
				vim.schedule(function()
					local bufs = vim.tbl_filter(function(b)
						return vim.bo[b].buflisted and vim.api.nvim_buf_is_valid(b)
					end, vim.api.nvim_list_bufs())

					if #bufs <= max_buffers then
						return
					end

					-- sort by lastused (oldest first)
					table.sort(bufs, function(a, b)
						return vim.fn.getbufinfo(a)[1].lastused < vim.fn.getbufinfo(b)[1].lastused
					end)

					-- close oldest buffers until we're at max, skip modified
					local to_close = #bufs - max_buffers
					for i = 1, #bufs do
						if to_close <= 0 then
							break
						end
						local buf = bufs[i]
						if not vim.bo[buf].modified then
							vim.api.nvim_buf_delete(buf, {})
							to_close = to_close - 1
						end
					end
				end)
			end,
		})
	end,
}
