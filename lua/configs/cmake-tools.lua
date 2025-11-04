local options = {
  cmake_runner = {
    name = "terminal",
    default_opts = {
      terminal = {
        split_direction = "horizontal",
        split_size = 6, -- Aquí controlas la altura
        single_terminal_per_instance = true, -- Reutiliza la misma terminal
        focus = false, -- No enfoca la terminal al ejecutar
      },
    },
  },
}

return options
