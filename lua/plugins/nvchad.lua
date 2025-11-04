return {
  {
    "nvchad/ui",
    config = function()
      require "nvchad"
    end,
  },
  --
  {
    "nvchad/base46",
    lazy = true,
    build = function()
      require("base46").load_all_highlights()
    end,
  },

  { "folke/which-key.nvim", event = "VeryLazy" },
  -- disable a default nvchad plugin
  { "nvim-tree/nvim-tree.lua", enabled = false },

  { "nvzone/volt", lazy = true },

  {
    "nvzone/minty",
    cmd = { "Shades", "Huefy" },
  },

  { "nvzone/menu", lazy = true },
}
