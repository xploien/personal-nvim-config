-- Tu keymap simplificado
local M = {}

-- Variable global para mantener referencia al buffer de terminal de Python
_G.python_terminal_buf = nil

local function get_or_create_python_terminal()
  if _G.python_terminal_buf and vim.api.nvim_buf_is_valid(_G.python_terminal_buf) then
    local windows = vim.fn.win_findbuf(_G.python_terminal_buf)
    if #windows > 0 then
      vim.api.nvim_set_current_win(windows[1])
      return _G.python_terminal_buf
    else
      vim.cmd "split"
      vim.api.nvim_win_set_height(0, 12)
      vim.api.nvim_win_set_buf(0, _G.python_terminal_buf)
      return _G.python_terminal_buf
    end
  end

  vim.cmd "split"
  vim.api.nvim_win_set_height(0, 12)
  vim.cmd "terminal"
  _G.python_terminal_buf = vim.api.nvim_get_current_buf()

  return _G.python_terminal_buf
end

local function run_python_in_terminal(filename)
  local term_buf = get_or_create_python_terminal()
  local job_id = vim.api.nvim_buf_get_var(term_buf, "terminal_job_id")

  vim.api.nvim_chan_send(job_id, "clear\n")
  vim.api.nvim_chan_send(job_id, "python3 '" .. filename .. "'\n")
  vim.cmd "wincmd p" -- Volver a la ventana anterior
end

vim.keymap.set("n", "<leader>R", function()
  local filename = vim.api.nvim_buf_get_name(0)
  local extension = filename:match "^.+(%..+)$" or ""

  if extension == ".py" then
    run_python_in_terminal(filename)
  else
    -- Para C++/CMake, simplemente usa CMakeRun
    -- cmake-tools se encarga del tamaño y reutilización
    vim.cmd "CMakeRun"
  end
end, { desc = "Run current file (CMake or Python)" })

return M
