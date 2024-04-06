local M = {}
M.conf = {
  mapping = "<leader>tt",
  toggles = {
    ["false"] = "true",
    ["False"] = "True",
  },
}

-- Finds the first ocurrence of a toggle word in a line
local function find_toggle_word(line)
  local found_word, substitute_word = "", ""
  local min_index = #line + 1
  local ocurrences = {}

  -- Finds first ocurrences of all toggle words
  for key, value in pairs(M.conf.toggles) do
    local key_index = string.find(line, key)
    local value_index = string.find(line, value)

    if key_index then
      table.insert(ocurrences, {index=key_index, found_word=key, substitute_word=value})
    end

    if value_index then
      table.insert(ocurrences, {index=value_index, found_word=value, substitute_word=key})
    end
  end

  -- Finds the first ocurrence of all ocurrences
  for _, ocurrence in ipairs(ocurrences) do
    if ocurrence.index < min_index or (ocurrence.index == min_index and #ocurrence.found_word > #found_word) then
      min_index = ocurrence.index
      found_word = ocurrence.found_word
      substitute_word = ocurrence.substitute_word
    end
  end

  return found_word, substitute_word
end

M.toggle_bool = function()
  if vim.o.modifiable == false then
    vim.print("toggl-bool.nvim: Cannot toggle. Buffer is not modifiable.")
    return
  end
  local line = vim.api.nvim_get_current_line()
  local _, col = unpack(vim.api.nvim_win_get_cursor(0))
  local sub_line = string.sub(line, col + 1)

  local found_word, substitute_word = find_toggle_word(sub_line)

  if(found_word ~= "") then
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
