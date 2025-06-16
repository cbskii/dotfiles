-- Use space key as <leader> key for easy key bindings
vim.g.mapleader = " "

-- General Keymaps
vim.keymap.set("n", "<C-J>", "<C-W><C-J>", { silent = true })
vim.keymap.set("n", "<C-K>", "<C-W><C-K>", { silent = true })
vim.keymap.set("n", "<C-L>", "<C-W><C-L>", { silent = true })
vim.keymap.set("n", "<C-H>", "<C-W><C-H>", { silent = true })
vim.keymap.set("n", "<C-u>", "u", { silent = true })
vim.keymap.set("n", "gd", "<C-]>", { silent = true })
vim.keymap.set("n", "<C-p>", ":FZF<CR>", { silent = true })
vim.keymap.set("n", "<C-t>", ":Tags<CR>", { silent = true })
vim.keymap.set("n", "<C-e>", ":Buffers<CR>", { silent = true })
vim.keymap.set("n", "<C-s>", ":Rg <C-R><C-W><CR>", { silent = true })
vim.keymap.set("n", "<Tab>", ":b#<CR>", { silent = true })
vim.keymap.set("n", "d", "<C-D>", { silent = true })
vim.keymap.set("n", "u", "<C-U>", { silent = true })
vim.keymap.set("n", "<leader>q", ":q<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":w<CR>", { silent = true })
vim.keymap.set("n", "<leader>-", ":split<CR>", { silent = true })
vim.keymap.set("n", "<leader>=", ":vsplit<CR>", { silent = true })

 -- Clear search highlight
vim.keymap.set("n", "<Esc><Esc>", ":silent! nohls<CR>", { silent = true })
vim.keymap.set("n", "<leader>c", ":silent! nohls<CR>", { silent = true })

-- Consistent search direction
vim.keymap.set("n", "n", ":/<CR>", { silent = true })
vim.keymap.set("n", "N", ":?<CR>", { silent = true })

-- Leap movement
require('leap').set_default_mappings()

-- Escape keymap settings
require("better_escape").setup {
}
