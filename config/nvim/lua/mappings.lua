require "nvchad.mappings"

local map = vim.keymap.set

-- Use semicolon for command mode
map("n", ";", ":", { desc = "CMD enter command mode" })

-- Quick escape from insert mode
map("i", "jk", "<ESC>", { desc = "Escape insert mode" })
map("i", "jj", "<ESC>", { desc = "Escape insert mode" })

-- Alternative command mode with leader
map("n", "<leader><leader>", ":", { desc = "Command mode" })

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", { desc = "Scroll down centered" })
map("n", "<C-u>", "<C-u>zz", { desc = "Scroll up centered" })

-- Quick edit mappings file
map("n", "<leader>cm", function()
  vim.cmd("edit " .. vim.fn.stdpath("config") .. "/lua/mappings.lua")
end, { desc = "Edit mappings.lua" })

-- Telescope live grep (NvChad already has this but we override for consistency)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", { desc = "Find text (grep)" })

-- Paste with new line above/below
map("n", "<leader>p", "O<Esc>p", { desc = "Paste above with new line" })
map("n", "<leader>P", "o<Esc>p", { desc = "Paste below with new line" })
