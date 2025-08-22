--function colorMe(color)
--	color = color or "noctishc"   -- or use oak
--	vim.cmd.colorscheme(color)
--	vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
--	vim.api.nvim_set_hl(0, "NormalFloat", {bg = ""none})
--	vim.cmd [[hi TabLineFill guibg=#00BA26 guifg=#222222 ]]
--	vim.cmd [[hi TabLine guibg=#00BA26 ]]
--end
--colorMe()

return {
	{
		"iagorrr/noctis-high-contrast.nvim",
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd.colorscheme("noctishc")
			vim.api.nvim_set_hl(0, "Normal", {bg = "none"})
			vim.api.nvim_set_hl(0, "NormalFloat", {bg = "none"})
			vim.cmd [[hi TabLineFill guibg=#00BA26 guifg=#222222 ]]
			vim.cmd [[hi TabLine guibg=#00BA26 ]]

			-- Set a custom background for Lazy's floating window
			vim.api.nvim_set_hl(0, "LazyNormal", { bg = "#1e1e2e", fg = "#ffffff" })
		end,
	},
	{
		"vigoux/oak",
		lazy = false,
		priority = 1000,
		--config = function()
		--	vim.cmd([[colorscheme oak]])
		--end,
	},
}
