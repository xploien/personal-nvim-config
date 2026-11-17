require "nvchad.autocmds"
local _typst_dark = false

vim.api.nvim_create_user_command("TypstPreviewDarkToggle", function()
  _typst_dark = not _typst_dark
  vim.cmd "TypstPreviewStop"
  require("typst-preview").setup {
    invert_colors = _typst_dark and "always" or "never",
    follow_cursor = true,
    dependencies_bin = { tinymist = "tinymist" },
  }
  vim.defer_fn(function()
    vim.cmd "TypstPreview"
    vim.notify("Typst preview: " .. (_typst_dark and "dark" or "light") .. " mode")
  end, 300)
end, { desc = "Toggle typst preview dark/light mode" })
