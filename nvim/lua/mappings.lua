require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")
map("i", "<C-CR>", "<ESC>o", { desc = "Insert new line below and enter insert mode" })
map("n", "<leader>cf", function ()
  vim.fn.setreg('+', vim.fn.expand('%'))
end, { desc = "Copy current file path to clipboard", noremap = true })

-- Workaround for https://github.com/neovim/neovim/issues/38646: vim.lsp.buf.code_action() doesn't
-- include diagnostic `data` field, which ruby-lsp needs for code actions.
map({ "n", "v" }, "<leader>ca", function()
  local bufnr = vim.api.nvim_get_current_buf()
  local lnum = vim.api.nvim_win_get_cursor(0)[1] - 1
  local diagnostics = vim.diagnostic.get(bufnr, { lnum = lnum })
  local lsp_diagnostics = vim.tbl_map(function(d)
    return d.user_data and d.user_data.lsp or nil
  end, diagnostics)
  lsp_diagnostics = vim.tbl_filter(function(d) return d ~= nil end, lsp_diagnostics)

  vim.lsp.buf.code_action({
    context = {
      diagnostics = lsp_diagnostics,
    },
  })
end)

map("i", "<C-A>", "copilot#Accept('\\<CR>')", {
  expr = true,
  replace_keycodes = false,
  silent = true,
  desc = "Accept Copilot suggestion",
})

map("n", "<leader>X", function()
  require("nvchad.tabufline").closeAllBufs()
end, { desc = "Close all buffers" })
map("n", "<C-T>", function()
  vim.cmd "tabnew"
end, { desc = "Open new tab" })

-- Open a new terminal and immediately enter insert mode
map("n", "<M-t>", function()
  vim.cmd "terminal"
  vim.cmd "startinsert"
end, { desc = "Open new terminal" })

-- Moving of lines
map("n", "<C-S-j>", ":m .+1<CR>==", { noremap = true, silent = true, desc = "Move line down" })
map("n", "<C-S-k>", ":m .-2<CR>==", { noremap = true, silent = true, desc = "Move line up" })
map("v", "<C-S-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines down" })
map("v", "<C-S-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true, desc = "Move selected lines up" })

--------------------------------------------------------------------------
-- TELESCOPE
--------------------------------------------------------------------------
map("n", "<leader>fs", function()
  require("telescope.builtin").lsp_workspace_symbols()
end, { desc = "LSP workspace symbols" })
map("n", "<leader>fr", function()
  require("telescope.builtin").lsp_references()
end, { desc = "LSP references" })
map("n", "<leader>fg", function()
  require("telescope").extensions.live_grep_args.live_grep_args()
end, { desc = "Live grep with args" })
map("n", "<leader>fA", function()
  require("telescope.builtin").builtin()
end, { desc = "Find all telescope pickers" })

map("n", "<leader>fW", function()
  local word = vim.fn.expand "<cword>"
  require("telescope").extensions.live_grep_args.live_grep_args {
    default_text = word,
  }
end, { desc = "Live grep current word" })

--------------------------------------------------------------------------
--- NEOTEST
--------------------------------------------------------------------------
map("n", "<leader>tt", function()
  if vim.bo.modified then
    vim.cmd "write"
  end
  require("neotest").run.run()
end, { desc = "Run nearest test" })

map("n", "<leader>tT", function()
  if vim.bo.modified then
    vim.cmd "write"
  end
  require("neotest").run.run(vim.fn.expand "%")
end, { desc = "Run all tests in current file" })

map("n", "<leader>ts", function()
  require("neotest").summary.toggle()
end, { desc = "Toggle test summary" })
map("n", "<leader>to", function()
  require("neotest").output.open { enter = true }
end, { desc = "Open test output" })
map("n", "<leader>td", function()
  require("neotest").run.run { strategy = "dap" }
end, { desc = "Debug nearest test" })
map("n", "<leader>tC", function()
  require("neotest").run.stop()
end, { desc = "Stop test run" })
map("n", "<leader>tr", function()
  require("neotest").run.run_last()
end, { desc = "Run last test" })
map("n", "<leader>tR", function()
  require("neotest").run.run_last { strategy = "dap" }
end, { desc = "Debug last test" })
map("n", "<leader>ta", function()
  require("neotest").run.attach()
end, { desc = "Attach to running test" })
map("n", "]u", function()
  require("neotest").jump.next { status = "failed" }
end, { desc = "Jump to next failed test" })
map("n", "[u", function()
  require("neotest").jump.prev { status = "failed" }
end, { desc = "Jump to previous failed test" })
map("n", "]n", function()
  require("neotest").jump.next()
end, { desc = "Jump to next test" })
map("n", "[n", function()
  require("neotest").jump.prev()
end, { desc = "Jump to previous test" })

--------------------------------------------------------------------------
--- SPLIT JOIN
--------------------------------------------------------------------------
map("n", "<leader>j", function()
  require("treesj").toggle()
end, { desc = "Toggle split/join block" })
