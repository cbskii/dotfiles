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
vim.keymap.set("t", "<Esc>", [[<C-\><C-n>]], { silent = true })

-- Open a new terminal and set the buffer name
vim.keymap.set('n', '<leader>t', function()
  vim.cmd('terminal')
  -- Wait for terminal to open, then rename
  vim.schedule(function()
    local name = vim.fn.input('Terminal name: ')
    if name ~= '' then
      vim.cmd('file ' .. name .. ' (term)')
    end
  end)
end, { noremap = true, silent = true })

 -- Clear search highlight
vim.keymap.set("n", "<Esc><Esc>", ":silent! nohls<CR>", { silent = true })

-- Consistent search direction
vim.keymap.set("n", "n", ":/<CR>", { silent = true })
vim.keymap.set("n", "N", ":?<CR>", { silent = true })

-- Use OSC52 for copying to clipboard on remote sessions
vim.keymap.set("v", "y", require("osc52").copy_visual)

-- Pattern for word starting with letter or digit and skipping symbols
local pattern = [[\<[A-Za-z0-9]\w*\>]]

local function jump_forward()
  vim.fn.search(pattern, 'W')
end

local function jump_backward()
  vim.fn.search(pattern, 'bW')
end

-- Remap w and b behavior to skip symbols
vim.keymap.set('n', 'w', jump_forward, { silent = true })
vim.keymap.set('n', 'b', jump_backward, { silent = true })

-- Leap movement
require('leap').set_default_mappings()
