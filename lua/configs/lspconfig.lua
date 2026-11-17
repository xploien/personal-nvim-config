require("nvchad.configs.lspconfig").defaults()

-- ==========================================
-- 1. CONFIGURACIONES ESPECÍFICAS DE SERVIDORES
-- ==========================================
-- ── Autocomando: keymaps de tinymist en attach ──────────────────────────
vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.typ",
  callback = function(args)
    local bufnr = args.buf
    vim.keymap.set("n", "<leader>tp", function()
      -- ... (lo que ya tienes)
    end, { buffer = bufnr, desc = "Typst: pin main file" })

    vim.keymap.set("n", "<leader>tR", function()
      -- ... (lo que ya tienes)
    end, { buffer = bufnr, desc = "Typst: restart LSP" })
  end,
})

-- ── Auto-trigger de typst-languagetool sin escribir a disco ─────────────
local lt_timer = nil

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  pattern = "*.typ",
  callback = function(args)
    local bufnr = args.buf

    if lt_timer then
      lt_timer:stop()
      lt_timer:close()
    end

    lt_timer = vim.uv.new_timer()
    lt_timer:start(800, 0, function()
      vim.schedule(function()
        local clients = vim.lsp.get_clients { bufnr = bufnr, name = "typst_languagetool" }
        local client = clients[1]
        if not client then
          return
        end

        client:notify("textDocument/didSave", {
          textDocument = { uri = vim.uri_from_bufnr(bufnr) },
          text = table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), "\n"),
        })
      end)
    end)
  end,
})

vim.lsp.config.lua_ls = {
  settings = {
    Lua = {
      diagnostics = {
        globals = { "vim" },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
        checkThirdParty = false,
      },
      telemetry = { enable = false },
    },
  },
}

vim.lsp.config.tinymist = {
  cmd = { "tinymist" },
  filetypes = { "typst" },
  single_file_support = true,
  offset_encoding = "utf-8",
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onSave",
    semanticTokens = "enable",
  },
}

vim.lsp.config.typst_languagetool = {
  cmd = { "typst-languagetool-lsp" },
  filetypes = { "typst" },
  single_file_support = true,
  init_options = {
    backend = "server",
    host = "http://localhost",
    port = 8081,
  },
  before_init = function(_, config)
    local bufname = vim.api.nvim_buf_get_name(0)
    if bufname ~= "" then
      config.init_options.root = vim.fn.fnamemodify(bufname, ":h") -- carpeta
      config.init_options.main = vim.fn.fnamemodify(bufname, ":t") -- nombre de archivo
    end
  end,
}

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
  root_markers = { ".clangd", "compile_commands.json", ".git", "CMakeLists.txt", "Makefile" },
  filetypes = { "c", "cpp", "objc", "objcpp" },
  init_options = {
    clangdFileStatus = true,
    usePlaceholders = true,
    completeUnimported = true,
    semanticHighlighting = true,
  },
}

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

vim.lsp.config.cssls = {
  settings = {
    css = { validate = true },
    less = { validate = true },
    scss = { validate = true },
  },
}

-- Solución al error de neocmakelsp: Le decimos a la nueva API cómo ejecutarlo
vim.lsp.config.neocmakelsp = {
  cmd = { "neocmakelsp", "--stdio" },
  filetypes = { "cmake" },
  root_markers = { "CMakeLists.txt", ".git" },
  single_file_support = true,
}

vim.lsp.config.verible = {
  cmd = { "verible-verilog-ls", "--rules_config_search" },
  filetypes = { "verilog", "systemverilog" },
  root_markers = { ".git", "verible.filelist" },
  single_file_support = true,
}

-- ==========================================
-- 2. CONFIGURACIÓN GLOBAL (Capabilities)
-- ==========================================

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

-- ==========================================
-- 3. ACTIVAR LOS SERVIDORES
-- ==========================================

-- Nota: stylua ya no está aquí, porque es un formateador
local servers = {
  "glsl_analyzer",
  "html",
  "cssls",
  "clangd",
  "tinymist",
  "basedpyright",
  "typst_languagetool",
  "neocmakelsp",
  "lua_ls",
  "taplo",
  "bashls",
  "jsonls",
  "qmlls",
  "emmet_ls",
  "vtsls",
  "verible",
}

vim.lsp.enable(servers)
