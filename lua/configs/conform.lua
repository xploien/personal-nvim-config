local options = {
  formatters_by_ft = {
    lua = { "stylua" },
    css = { "prettier" },
    html = { "prettier" },
    javascript = { "prettier" },
    -- javascriptreact = { "prettier" },
    cpp = { "clang_format" },
    c = { "clang_format" },
    verilog = { "verible" },
    systemverilog = { "verible" },
  },
  formatters = {
    clang_format = {
      prepend_args = {
        "--style={BasedOnStyle: LLVM, IndentWidth: 2, ColumnLimit: 80, BreakBeforeBraces: Attach, AllowShortFunctionsOnASingleLine: Empty, AllowShortIfStatementsOnASingleLine: Never, SpaceBeforeParens: ControlStatements}",
      },
    },
  },
  format_on_save = {
    timeout_ms = 500,
    lsp_fallback = true,
  },
}

return options
