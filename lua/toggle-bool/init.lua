local M = {}
M.conf = {
  mapping = "<leader>tt",
  toggles = {
    ["false"] = "true",
    ["False"] = "True",
  },
}

local function find_toggle_word(sub_line)
  local found_word, substitute_word
  for key, value in pairs(M.conf.toggles) do
    if string.find(sub_line, key) then
      found_word = key
      substitute_word = value
    elseif string.find(sub_line, value) then
      found_word = value
      substitute_word = key
    end
  end

  return found_word, substitute_word
end

M.toggle_bool = function()
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local sub_line = string.sub(line, col + 1)

  local found_word, substitute_word = find_toggle_word(sub_line)

  if(found_word) then
    local new_sub_line = string.gsub(sub_line, found_word, substitute_word, 1)
    local new_line = string.sub(line, 1, col) .. new_sub_line
    vim.api.nvim_set_current_line(new_line)
  end
end

M.setup = function(opts)
  opts = opts or {}
  if opts.additional_toggles then
    M.conf.toggles = vim.tbl_extend("force", M.conf.toggles, opts.additional_toggles)
  end
  if opts.mapping then
    M.conf.mapping = opts.mapping
  end
  vim.keymap.set("n", M.conf.mapping, M.toggle_bool)
end

return M
