return {
	"tajirhas9/muslim.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-lualine/lualine.nvim",
	},
	opts = {
		refresh = 1, -- Refresh interval in minutes to update prayer waqt times
		latitude = 33.4922, -- MANDATORY TO BE PROVIDED. Geolocation latitude of the place of calculation
		longitude = -7.3184, -- MANDATORY TO BE PROVIDED. Geolocation longitude of the place of calculation
		utc_offset = 0, -- timezone, default is GMT+0
		school = "hanafi", -- school of thought
		method = "Egypt", -- calculation method. default is Muslim World League
		timezone = "casablanca",
		time_format = "24h", -- time display format: '12H' for 12-hour with AM/PM, '24h' for 24-hour
		countdown_only = true, -- show only countdown to next prayer
	},
	config = function(_, opts)
		require("muslim").setup(opts)
		require("lualine").setup({
			sections = {
				lualine_x = {
					{ "datetime", style = "default" },
					{ require("muslim").prayer_time, id = "muslim.nvim", color = { fg = "#f88808" } },
				},
			},
		})
	end,
}
