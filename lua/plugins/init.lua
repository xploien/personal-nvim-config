return {

  {
    "stevearc/conform.nvim",
    event = "BufWritePre", -- uncomment for format on save
    opts = require "configs.conform",
  },

  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        -- LSPs
        "lua-language-server",
        "tinymist",
        "clangd",
        "basedpyright",
        "css-lsp",
        "html-lsp",
        "taplo",
        "bash-language-server",
        "json-lsp",
        "emmet-ls",

        -- Formateadores (Los que pusiste en tu conform.lua)
        "stylua",
        "prettier", -- Agregado para CSS, HTML, JS
        "clang-format", -- Agregado para C y C++

        -- Linters (Los que tienes en nvim-lint)
        "tidy",
        "eslint_d",
        "verible",
      },
    },
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
      vim.lsp.config.qmlls = {} -- Configuración básica
      vim.lsp.enable "qmlls" -- Activar el servidor
    end,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Es más seguro usar "*" para que lazy maneje la versión
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {}
    end,
  },
  {
    "mfussenegger/nvim-lint",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      local lint = require "lint"

      lint.linters_by_ft = {
        html = { "tidy" },
        javascript = { "eslint_d" },
        verilog = { "verilator" },
        systemverilog = { "verilator" },
      }

      -- Añadimos TextChanged para que sea instantáneo mientras escribes
      vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave", "TextChanged" }, {
        callback = function()
          lint.try_lint()
        end,
      })
    end,
  },
  {
    "barrett-ruth/live-server.nvim",
    ft = { "html", "css", "javascript", "javascriptreact", "typescriptreact" },
    config = function()
      -- Ya no llamamos a .setup()
      -- Si necesitas configurar algo (puerto, navegador), se hace así:
      -- vim.g.live_server = {
      --   port = 8080,
      --   browser = "firefox",
      -- }
    end,
  }, --

  {
    "benfowler/telescope-luasnip.nvim",
    -- Lazy load only when command or keymap is used
    lazy = true,
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "L3MON4D3/LuaSnip",
    },
  },
  -- test new blink
  { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "verilog",
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
