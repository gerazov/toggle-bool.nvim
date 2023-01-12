local M = {
  mapping = "<leader>tt",
  toggles = {
    ["false"] = "true",
    ["False"] = "True",
  },
}

M.toggle_bool = function()
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local sub_line = string.sub(line, col + 1)
  for key, value in pairs(M.toggles) do
    if string.find(sub_line, key) then
      local new_sub_line = string.gsub(sub_line, key, value, 1)
      local new_line = string.sub(line, 1, col) .. new_sub_line
      vim.api.nvim_set_current_line(new_line)
    elseif string.find(sub_line, value) then
      local new_sub_line = string.gsub(sub_line, value, key, 1)
      local new_line = string.sub(line, 1, col) .. new_sub_line
      vim.api.nvim_set_current_line(new_line)
    end
  end
end

M.setup = function(opts)
  opts = opts or {}
  if opts.additional_toggles then
    M.toggles = vim.tbl_extend("force", M.toggles, opts.additional_toggles)
  end
  if opts.mapping then
    M.mapping = opts.mapping
  end
  vim.keymap.set("n", M.mapping, M.toggle_bool)
end

return M
