-- Toggle "zooming" the current window into its own tab.
--   - If the whole editor has a single window, there's nothing to zoom.
--   - If the current tab is a single window whose buffer has a genuine
--     "origin" (another tab where that buffer sits among multiple windows),
--     this tab is a zoom tab: close it to go back.
--   - If the current tab has multiple windows, jump to an existing zoom tab
--     for this buffer if one exists, otherwise create one.
local function zoom_toggle()
  local win_count = #vim.api.nvim_tabpage_list_wins(0)
  local tab_count = #vim.api.nvim_list_tabpages()

  if win_count == 1 and tab_count == 1 then
    return
  end

  local buf = vim.api.nvim_get_current_buf()
  local current_tab = vim.api.nvim_get_current_tabpage()

  if win_count == 1 then
    for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
      if tab ~= current_tab then
        local wins = vim.api.nvim_tabpage_list_wins(tab)
        if #wins > 1 then
          for _, win in ipairs(wins) do
            if vim.api.nvim_win_get_buf(win) == buf then
              vim.cmd "tabclose"
              return
            end
          end
        end
      end
    end
    return
  end

  for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
    local wins = vim.api.nvim_tabpage_list_wins(tab)
    if #wins == 1 and vim.api.nvim_win_get_buf(wins[1]) == buf then
      vim.api.nvim_set_current_tabpage(tab)
      return
    end
  end

  vim.cmd "tab split"
end

local function close_all_other_windows()
  local current_win = vim.api.nvim_get_current_win()
  local wins = vim.api.nvim_tabpage_list_wins(0)

  for _, win in ipairs(wins) do
    if win ~= current_win then
      vim.api.nvim_win_close(win, true)
    end
  end
end

return { zoom_toggle = zoom_toggle, close_all_other_windows = close_all_other_windows }

