vim.g.mapleader = " "
vim.keymap.set("n","<leader>z",function() 
	vim.cmd("tabnew | Ex ") 
end)
vim.cmd([[
  augroup NetrwLineNumbers
    autocmd!
    autocmd FileType netrw setlocal number
  augroup END
]])

