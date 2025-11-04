require("nvchad.configs.lspconfig").defaults()
-- Configuración específica para clangd con clang-tidy (modo conservador)
vim.lsp.config.clangd = {
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--completion-style=detailed",
    "--header-insertion=iwyu",
    "--offset-encoding=utf-8",
    "--query-driver=/usr/bin/gcc,/usr/bin/g++,/usr/bin/clang,/usr/bin/clang++",
  },
  root_markers = {
    ".clangd",
    "compile_commands.json",
    ".git",
    "CMakeLists.txt",
    "Makefile",
  },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  init_options = {
    -- fallbackFlags = { "-std=c++17", "-Wall", "-Wextra" },
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

-- Configuración mejorada para basedpyright (Python)
vim.lsp.config.basedpyright = {
  settings = {
    basedpyright = {
      analysis = {
        autoSearchPaths = true,
        diagnosticMode = "workspace",
        useLibraryCodeForTypes = true,
        typeCheckingMode = "basic",
      },
    },
  },
}

local servers = {
  "glsl_analyzer",
  "html",
  "cssls",
  "clangd",
  "tinymist",
  "basedpyright",
  "neocmakelsp",
  "codelldb",
  "debugpy",
  "lua-language-server",
  "stylua",
  "taplo",
  "bash-language-server",
  "jsonls",
  "neocmake",
  "qmlls",
}

vim.lsp.enable(servers)

-- Configuración adicional para todos los LSP servers
vim.lsp.config("*", {
  capabilities = {
    textDocument = {
      completion = {
        completionItem = {
          snippetSupport = true,
        },
      },
      foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      },
    },
  },
})
