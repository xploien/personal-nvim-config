return {

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      vim.lsp.config.qmlls = {} -- Configuración básica
      vim.lsp.enable "qmlls" -- Activar el servidor
    end,
  },

  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "vim",
        "lua",
        "vimdoc",
        "html",
        "css",
        "c",
        "cpp",
        "python",
        "typst",
        "javascript",
        "bash",
        "toml",
        "json",
        "jsonc",
        "cmake",
        "qmljs",
        "glsl",
      },
    },
  },
}
