return {
	"nvim-telescope/telescope.nvim",
	config = function()
		local builtin = require('telescope.builtin')  -- variable builtin is local and imports telescope.builtin sort of like python import as 
		vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
		vim.keymap.set('n','C-p>', builtin.git_files,{})
		--vim.keymap.set('n', '<leader>fs', function()
		--builtin.grep_string({ search = vim.fn.input("Grep > ")});
		--	end)
		vim.keymap.set('n', '<leader>fs', function()
			-- Custom prompt for global file search
			local search_dir = vim.fn.input("Search in dir: ", "/etc/,/usr/", "file")  -- Default to searching in /etc/ or /usr/
			builtin.find_files({
				search_dirs = vim.split(search_dir, ",")  -- Allow comma-separated directories
			})
		end)
		require('telescope').setup{
			defaults = {
				file_ignore_patterns = { "node_modules", ".git", "dist" }, -- u can just mention more folders/ files for it to ignore 
				-- prompt_position = "top",  -- move prompt to the top
				layout_strategy = "horizontal",
				mappings = {
					i = {        				
						["<CR>"] = function(prompt_bufnr)
								vim.cmd("stopinsert")  -- This stops insert mode (goes to normal mode)
							  end,
					},
				  	n = {
						["<CR>"] = require('telescope.actions').select_tab,  -- Confirm selection in normal mode        
						["o"] = require('telescope.actions').select_default,  -- Open in new tab
				  	--	["<C-j>"] = require('telescope.actions').move_selection_next,
				  	--	["<C-k>"] = require('telescope.actions').move_selection_previous,
		  			},
				},
	  		}
	}
	end,
}
