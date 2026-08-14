return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      sources = {
        explorer = {
          hidden = true, -- show dotfiles
          ignored = false, -- hide gitignored files
          exclude = { "GoogleDrive" },
        },
        files = {
          hidden = true, -- show dotfiles
          ignored = false, -- hide gitignored files
          exclude = { "GoogleDrive" },
        },
        grep = {
          hidden = true, -- show dotfiles
          ignored = false, -- hide gitignored files
          exclude = { "GoogleDrive" },
        },
      },
    },
  },
}
