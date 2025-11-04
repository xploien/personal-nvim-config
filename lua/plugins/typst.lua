return {
  -- Plugin de sintaxis para Typst
  {
    "kaarmu/typst.vim",
    ft = { "typst" }, -- Lazy load solo para archivos Typst
  },

  -- Plugin de vista previa para Typst
  {
    "chomosuke/typst-preview.nvim",
    cmd = { "TypstPreview", "TypstPreviewToggle", "TypstPreviewUpdate" }, -- Lazy load para comandos
    build = function()
      require("typst-preview").update()
    end, -- Compila el plugin al instalarlo
    opts = {
      dependencies_bin = {
        tinymist = "tinymist", -- Dependencia binaria
      },
    },
  },
}
