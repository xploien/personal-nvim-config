local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

-- Dos figuras en una fila con grid
local typst_two_figures = s("twofig", {
  t "#figure(",
  t { "", "  grid(" },
  t { "", "    columns: 2," },
  t { "", "    gutter: " },
  i(1, "1em"),
  t ",",
  t { "", '    image("' },
  i(2, "fig1.png"),
  t '", width: 100%),',
  t { "", '    image("' },
  i(3, "fig2.png"),
  t '", width: 100%),',
  t { "", "  )," },
  t { "", "  caption: [" },
  i(4, "Caption aquí"),
  t "],",
  t { "", ") <" },
  i(5, "fig:label"),
  t ">",
})

-- Una figura simple
local typst_figure = s("fig", {
  t "#figure(",
  t { "", '  image("' },
  i(1, "imagen.png"),
  t '", width: ',
  i(2, "80%"),
  t "),",
  t { "", "  caption: [" },
  i(3, "Caption"),
  t "],",
  t { "", ") <" },
  i(4, "fig:label"),
  t ">",
})

ls.add_snippets("typst", { typst_two_figures, typst_figure })
