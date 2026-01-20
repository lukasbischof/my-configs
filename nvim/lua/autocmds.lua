require "nvchad.autocmds"

-- Set relative line numbers in normal mode
-- Set absolute line numbers in insert mode
vim.cmd [[
  augroup numbertoggle
    autocmd!
    autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &nu && mode() != "i" | set rnu   | endif
    autocmd BufLeave,FocusLost,InsertEnter,WinLeave   * if &nu                  | set nornu | endif
  augroup END
]]

-- Highlight yanked text
vim.cmd [[
  augroup highlight_yank
    autocmd!
    autocmd TextYankPost * silent! lua vim.highlight.on_yank()
  augroup END
]]

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local save_cursor = vim.fn.getpos(".") -- Save cursor position
    vim.cmd [[%s/\s\+$//e]] -- Trim trailing whitespace
    vim.fn.setpos(".", save_cursor) -- Restore cursor position
  end,
})
