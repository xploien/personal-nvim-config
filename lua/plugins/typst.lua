-- al inicio de typst.lua, antes del return {

vim.api.nvim_create_autocmd("LspAttach", {
  pattern = "*.typ",
  callback = function(args)
    local bufnr = args.buf

    vim.keymap.set("n", "<leader>tp", function()
      local clients = vim.lsp.get_clients { bufnr = bufnr, name = "tinymist" }
      local client = clients[1]
      if not client then
        return
      end

      local ok = pcall(function()
        client:exec_cmd({
          title = "Pin main file", -- ← campo requerido por el tipo lsp.Command
          command = "tinymist.pinMain",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }, { bufnr = bufnr })
      end)
      if not ok then
        client:request("workspace/executeCommand", {
          title = "Pin main file",
          command = "tinymist.pinMain",
          arguments = { vim.api.nvim_buf_get_name(0) },
        }, nil, bufnr)
      end

      vim.notify("Typst: main pinned → " .. vim.fn.expand "%:t")
    end, { buffer = bufnr, desc = "Typst: pin main file" })

    vim.keymap.set("n", "<leader>tR", function()
      local clients = vim.lsp.get_clients { name = "tinymist" }
      for _, client in ipairs(clients) do
        client:stop(true)
      end
      vim.defer_fn(function()
        vim.cmd "edit"
      end, 500)
    end, { buffer = bufnr, desc = "Typst: restart LSP" })
  end,
})

return {
  {
    "stevearc/conform.nvim",
    ft = { "typst" },
    opts = {
      formatters_by_ft = {
        -- lsp_format = "prefer" usa tinymist si está disponible, si no cae a typstyle binario
        typst = { "typstyle", lsp_format = "prefer" },
      },
      format_on_save = {
        timeout_ms = 1000,
        lsp_format = "prefer",
      },
    },
  },

  -- ── Preview ────────────────────────────────────────────────────────────
  {
    "chomosuke/typst-preview.nvim",
    ft = "typst",
    version = "1.*", -- fija versión para evitar breaking changes
    build = function()
      require("typst-preview").update()
    end,
    keys = {
      { "<leader>tv", "<cmd>TypstPreviewToggle<cr>", ft = "typst", desc = "Typst: toggle preview" },
    },
    opts = {
      dependencies_bin = {
        tinymist = "tinymist",
      },
      follow_cursor = true,
      invert_colors = "never", -- dark mode automático en el preview
    },
  },
}
