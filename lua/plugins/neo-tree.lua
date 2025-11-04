return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    enabled = false,
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons", -- optional, but recommended
    },
    lazy = true,
    cmd = "Neotree",
    init = function()
      require "nvchad.mappings" -- Aquí se cargan los mappings externos

      -- Función para abrir neo-tree solo para directorios
      local function open_neotree_for_directory()
        if vim.fn.argc() == 1 then
          local arg = vim.fn.argv(0)
          local stat = vim.uv.fs_stat(arg)

          if stat and stat.type == "directory" then
            -- Es un directorio, cambiar a él y abrir neo-tree
            vim.cmd("cd " .. vim.fn.fnameescape(arg))
            vim.cmd "Neotree show"
            -- Enfocar neo-tree después de abrirlo
            vim.defer_fn(function()
              vim.cmd "Neotree focus"
            end, 100)
            return true
          elseif stat and stat.type == "file" then
            -- Es un archivo, cambiar al directorio del archivo pero NO abrir neo-tree
            local dir = vim.fn.fnamemodify(arg, ":h")
            vim.cmd("cd " .. vim.fn.fnameescape(dir))
            return false
          end
        elseif vim.fn.argc() > 1 then
          -- Múltiples archivos, cambiar al directorio del primer archivo pero NO abrir neo-tree
          local first_arg = vim.fn.argv(0)
          local dir = vim.fn.fnamemodify(first_arg, ":h")
          vim.cmd("cd " .. vim.fn.fnameescape(dir))
          return false
        end

        return false
      end

      -- Autocomando para manejar la apertura automática
      vim.api.nvim_create_autocmd("VimEnter", {
        nested = true,
        callback = function()
          vim.defer_fn(function()
            open_neotree_for_directory()
          end, 50)
        end,
      })

      -- Autocomando adicional para el caso edge de buffer vacío con directorio
      vim.api.nvim_create_autocmd("BufEnter", {
        once = true,
        callback = function(args)
          local path = vim.api.nvim_buf_get_name(args.buf)
          if path == "" and vim.fn.argc() == 1 then
            local arg = vim.fn.argv(0)
            local stat = vim.uv.fs_stat(arg)
            if stat and stat.type == "directory" then
              vim.cmd "Neotree show"
              -- Enfocar neo-tree después de abrirlo
              vim.defer_fn(function()
                vim.cmd "Neotree focus"
              end, 100)
            end
          end
        end,
      })
    end,
    opts = {
      close_if_last_window = true,
      enable_git_status = true,
      filesystem = {
        follow_current_file = { enabled = true },
        hijack_netrw_behavior = "open_current",
        use_libuv_file_watcher = true,
      },
      window = {
        width = 30,
        mappings = {
          -- ["<S-CR>"] = "system_open",
          ["<Space>"] = false,
          ["[b"] = "prev_source",
          ["]b"] = "next_source",
          -- O = "system_open",
          -- Y = "copy_selector",
          h = "close_node",
          l = "open",
        },
        fuzzy_finder_mappings = { -- define keymaps for filter popup window in fuzzy_finder_mode
          ["<C-J>"] = "move_cursor_down",
          ["<C-K>"] = "move_cursor_up",
        },
      },
    },
  },
}
