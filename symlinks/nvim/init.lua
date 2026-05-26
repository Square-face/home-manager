vim.g.mapleader = " "

vim.o.number = true
vim.o.relativenumber = true

vim.o.swapfile = false

-- Resonable tabs, fight me
vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.winborder = "rounded"
vim.o.completeopt = 'fuzzy,menuone,noselect,popup'

vim.pack.add({
    'https://github.com/neovim-treesitter/nvim-treesitter',
    'https://github.com/neovim-treesitter/treesitter-parser-registry',
})
