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

-- Workaround for a Neovim 0.12 segfault: neotest's attach float (<leader>ta) uses a
-- terminal buffer with bufhidden=wipe. Opening another float from terminal mode makes
-- neotest's auto_close autocmd close (and thus wipe) that buffer from inside
-- nvim_open_win, which crashes the editor. Keeping the buffer around avoids it.
vim.api.nvim_create_autocmd("FileType", {
  pattern = "neotest-attach",
  callback = function(args)
    vim.schedule(function()
      if vim.api.nvim_buf_is_valid(args.buf) then
        vim.bo[args.buf].bufhidden = "hide"
      end
    end)
  end,
})

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
    local save_cursor = vim.fn.getpos "." -- Save cursor position
    vim.cmd [[%s/\s\+$//e]] -- Trim trailing whitespace
    vim.fn.setpos(".", save_cursor) -- Restore cursor position
  end,
})

-- Update terminal title on buffer switch
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = "*",
  callback = function()
    local cwd_basename = vim.fn.fnamemodify(vim.fn.getcwd(), ":t")
    local buffer_name = vim.fn.expand "%:t"
    if buffer_name == "" then
      buffer_name = "[No Name]"
    end

    -- Get git branch if in a git repository
    local git_branch = ""
    local git_command = "git branch --show-current 2>/dev/null"
    local handle = io.popen(git_command)
    if handle then
      local result = handle:read "*a"
      handle:close()
      if result and result ~= "" then
        git_branch = " (" .. result:gsub("%s+$", "") .. ")"
      end
    end

    local title = string.format("Neovim: %s %s%s", cwd_basename, buffer_name, git_branch)

    io.write("\027]0;" .. title .. "\007")
    io.flush()
  end,
})
