vim.pack.add({
    'https://github.com/neovim-treesitter/nvim-treesitter',
    'https://github.com/neovim-treesitter/treesitter-parser-registry',
})

vim.g.mapleader = " "
vim.g.maplocalleader = "-"

vim.o.number = true
vim.o.relativenumber = true

vim.o.swapfile = false
vim.o.smartindent = true

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.expandtab = true

vim.o.winborder = "rounded"
vim.o.completeopt = 'fuzzy,menuone,noselect,popup'
