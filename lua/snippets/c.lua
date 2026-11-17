local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

local state_enum = s("senum", {
  t "typedef enum {",
  t { "", "    " },
  i(1, "STATE_0"),
  t " = 0,",
  t { "", "    " },
  i(2, "STATE_1"),
  t ",",
  t { "", "    MAX_" },
  i(3, "STATES"),
  t " // Para ciclos automáticos",
  t { "", "} " },
  i(4, "SystemState"),
  t ";",
})

ls.add_snippets("c", { state_enum })
ls.add_snippets("cpp", { state_enum })
