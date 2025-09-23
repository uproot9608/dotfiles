-- Leader key
vim.g.mapleader = " "
-- vim.g.maplocalleader = " "

-- Fonts
vim.g.have_nerd_font = true 

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true
vim.o.wrap = false

-- Tabs 
vim.o.expandtab = false 
vim.o.tabstop = 4 
vim.o.shiftwidth = 4 


-- Show mode (not needed if with status line)
vim.o.showmode = true

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- Enable break indent
vim.o.breakindent = true

-- Save undo history
-- Set path in .zshrc 
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
-- 999 to always stay in the middle
vim.o.scrolloff = 12

-- Visual block mode virtual blocks
vim.o.virtualedit = "block"

-- Incremental changes 
vim.o.inccommand = "split"

-- True colors 
vim.o.termguicolors = true

-- Raise a dialog asking if you wish to save the current file(s)
vim.o.confirm = true

-- Set up diagnostics

vim.diagnostic.config {
	virtual_lines = true
}
