return {
  "max397574/better-escape.nvim",
  event = "InsertEnter",
  opts = {
    timeout = vim.o.timeoutlen, -- Timing threshold (uses Neovim's default timeoutlen)
    default_mappings = true, -- Set to false if you want to wipe defaults and write your own
    mappings = {
      i = { -- Insert mode mappings
        j = {
          k = "<Esc>", -- Map 'jk' to escape insert mode
          j = "<Esc>", -- Map 'jj' to escape insert mode
        },
        k = {
          j = "<Esc>", -- Map 'kj' to escape insert mode
        },
      },
      c = { -- Command mode mappings
        j = {
          k = "<C-c>",
        },
      },
    },
  },
}
