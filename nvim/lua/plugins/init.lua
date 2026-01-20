return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    opts = require "configs.conform",
  },

  -- These are some examples, uncomment them if you want to see them work!
  {
    "neovim/nvim-lspconfig",
    config = function()
      require "configs.lspconfig"
    end,
  },

  -- test new blink
  -- { import = "nvchad.blink.lazyspec" },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        "c",
        "css",
        "dart",
        "elixir",
        "go",
        "haskell",
        "html",
        "javascript",
        "lua",
        "markdown_inline",
        "markdown",
        "python",
        "ruby",
        "rust",
        "swift",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "yaml"
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    event = "VeryLazy",
    opts = {
      move = {
        enable = true,
        set_jumps = true,
        keys = {
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]c"] = "@class.outer",
            ["]p"] = "@parameter.inner",
            ["]]"] = "@function.outer",
          },
          goto_next_end = { ["]F"] = "@function.outer", ["]C"] = "@class.outer", ["]P"] = "@parameter.inner" },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[c"] = "@class.outer",
            ["[p"] = "@parameter.inner",
            ["[["] = "@function.outer",
          },
          goto_previous_end = { ["[F"] = "@function.outer", ["[C"] = "@class.outer", ["[P"] = "@parameter.inner" },
        },
      },
      select = {
        enable = true,
        lookahead = true,
        keymaps = {
          ["af"] = "@function.outer",
          ["if"] = "@function.inner",
          ["aC"] = "@class.outer",
          ["iC"] = "@class.inner",
          ["ac"] = "@call.outer",
          ["ic"] = "@call.inner",
          ["ib"] = "@block.inner",
          ["ab"] = "@block.outer",
          ["il"] = "@loop.inner",
          ["al"] = "@loop.outer",
          ["ap"] = "@parameter.outer",
          ["ip"] = "@parameter.inner",
        },
      },
    },
    config = require "configs.treesitter-textobjects",
  },

  {
    "mrcjkb/haskell-tools.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    version = "^2", -- Recommended
    ft = { "haskell", "lhaskell", "cabal", "cabalproject" },
  },

  {
    "slim-template/vim-slim",
    ft = "slim",
    lazy = true,
  },

  {
    "kylechui/nvim-surround",
    version = "*", -- Use for stability; omit to use `main` branch for the latest features
    event = "VeryLazy",
    config = function()
      require("nvim-surround").setup {
        -- Configuration here, or leave empty to use defaults
      }
    end,
  },

  {
    "github/copilot.vim",
    lazy = false,
    config = function()
      vim.g.copilot_no_tab_map = true
    end,
  },

  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = false,
    opts = {},
  },

  {
    "f-person/git-blame.nvim",
    -- load the plugin at startup
    event = "VeryLazy",
    -- Because of the keys part, you will be lazy loading this plugin.
    -- The plugin will only load once one of the keys is used.
    -- If you want to load the plugin at startup, add something like event = "VeryLazy",
    -- or lazy = false. One of both options will work.
    opts = {
      -- your configuration comes here
      -- for example
      enabled = true, -- if you want to enable the plugin
      message_template = " <summary> • <date> • <author> • <<sha>>", -- template for the blame message, check the Message template section for more options
      date_format = "%m-%d-%Y %H:%M:%S", -- template for the date, check Date format section for more options
      virtual_text_column = 100, -- virtual text start column, check Start virtual text at column section for more options
    },
  },

  {
    "nvim-neotest/neotest",
    event = "VeryLazy",
    dependencies = {
      "nvim-neotest/nvim-nio",
      "nvim-lua/plenary.nvim",
      "antoinemadec/FixCursorHold.nvim",
      "nvim-treesitter/nvim-treesitter",
      "olimorris/neotest-rspec",
    },
    config = function()
      require("neotest").setup {
        adapters = {
          require "neotest-rspec",
          require "neotest-python" {
            dap = { justMyCode = false },
          },
        },
      }
    end,
  },

  {
    "nvim-neotest/neotest-python",
    lazy = true,
  },

  {
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
  },

  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "suketa/nvim-dap-ruby",
    },
    config = function()
      require("dap-ruby").setup()
    end,
  },

  {
    "tpope/vim-rails",
    ft = { "ruby", "eruby", "slim" },
    cond = function()
      local gemfile = vim.fn.findfile("Gemfile", ".;")
      return gemfile ~= ""
    end,
  },

  {
    "nvim-telescope/telescope-live-grep-args.nvim",
    -- This will not install any breaking changes.
    -- For major updates, this must be adjusted manually.
    version = "^1.0.0",
  },

  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "VeryLazy",
    config = function()
      require("treesj").setup {
        use_default_keymaps = false,
      }
    end,
  },
}
