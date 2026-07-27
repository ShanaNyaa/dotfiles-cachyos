-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Re-enable unnamedplus so yanking automatically sends to system clipboard
vim.opt.clipboard = "unnamedplus"

-- Tell Neovim to channel clipboard copies/pastes through native OSC 52 sequences
-- vim.g.clipboard = {
--   name = "OSC 52 Native",
--   copy = {
--     ["+"] = require("vim.ui.clipboard.osc52").copy("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").copy("*"),
--   },
--   paste = {
--     ["+"] = require("vim.ui.clipboard.osc52").paste("+"),
--     ["*"] = require("vim.ui.clipboard.osc52").paste("*"),
--   },
-- }

-- Tell Neovim to channel clipboard copies/pastes through macOS pbcopy/pbpaste commands
vim.g.clipboard = {
  name = "macOS-Clipboard",
  copy = {
    ["+"] = "pbcopy",
    ["*"] = "pbcopy",
  },
  paste = {
    ["+"] = "pbpaste",
    ["*"] = "pbpaste",
  },
}
