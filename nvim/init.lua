vim.g.base46_cache = vim.fn.stdpath "data" .. "/base46/"
vim.g.mapleader = " "

-- Configure Copilot to use Node.js from asdf
vim.g.node_host_prog = '~/.local/share/mise/installs/node/25.2.1/lib/node_modules'
vim.g.copilot_node_command = '~/.local/share/mise/installs/node/25.2.1/bin/node'

-- bootstrap lazy and all plugins
local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

if not vim.uv.fs_stat(lazypath) then
  local repo = "https://github.com/folke/lazy.nvim.git"
  vim.fn.system { "git", "clone", "--filter=blob:none", repo, "--branch=stable", lazypath }
end

vim.opt.rtp:prepend(lazypath)

local lazy_config = require "configs.lazy"

-- load plugins
require("lazy").setup({
  {
    "NvChad/NvChad",
    lazy = false,
    branch = "v2.5",
    import = "nvchad.plugins",
  },

  { import = "plugins" },
}, lazy_config)

local telescope = require("telescope")
local lga_actions = require("telescope-live-grep-args.actions")

telescope.setup {
  extensions = {
    live_grep_args = {
      auto_quoting = true,
      mappings = {
        i = {
          ["<C-k>"] = lga_actions.quote_prompt(),
          ["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
        },
      },
    }
  }
}
require("telescope").load_extension "live_grep_args"

-- load theme
dofile(vim.g.base46_cache .. "defaults")
dofile(vim.g.base46_cache .. "statusline")

require "options"
require "autocmds"

vim.schedule(function()
  require "mappings"
end)

--------------------------------------------------------------------------
-- CUSTOM
--------------------------------------------------------------------------

require "folding"
require "misc"

require("refactoring").setup {}

vim.g.VM_maps = {
  ["Find Under"] = "<M-n>",
  ["Find Subword Under"] = "<M-n>",
  ["Add Cursor Up"] = "<M-k>",
  ["Add Cursor Down"] = "<M-j>"
}
