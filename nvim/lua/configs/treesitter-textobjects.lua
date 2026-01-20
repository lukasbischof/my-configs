return function(_, opts)
  local TS = require "nvim-treesitter-textobjects"
  TS.setup(opts)

  local function attach(buf)
    if not (vim.tbl_get(opts, "move", "enable")) then
      return
    end

    ---@type table<string, table<string, string>>
    local moves = vim.tbl_get(opts, "move", "keys") or {}

    for method, keymaps in pairs(moves) do
      for key, query in pairs(keymaps) do
        local queries = type(query) == "table" and query or { query }
        local parts = {}
        for _, q in ipairs(queries) do
          local part = q:gsub("@", ""):gsub("%..*", "")
          part = part:sub(1, 1):upper() .. part:sub(2)
          table.insert(parts, part)
        end
        local desc = table.concat(parts, " or ")
        desc = (key:sub(1, 1) == "[" and "Prev " or "Next ") .. desc
        desc = desc .. (key:sub(2, 2) == key:sub(2, 2):upper() and " End" or " Start")
        if not (vim.wo.diff and key:find "[cC]") then
          vim.keymap.set({ "n", "x", "o" }, key, function()
            require("nvim-treesitter-textobjects.move")[method](query, "textobjects")
          end, {
            buffer = buf,
            desc = desc,
            silent = true,
          })
        end
      end
    end

    if vim.tbl_get(opts, "select", "enable") then
      ---@type table<string, string>
      local selects = vim.tbl_get(opts, "select", "keymaps") or {}

      for key, query in pairs(selects) do
        local queries = type(query) == "table" and query or { query }
        local parts = {}
        for _, q in ipairs(queries) do
          local part = q:gsub("@", ""):gsub("%..*", "")
          part = part:sub(1, 1):upper() .. part:sub(2)
          table.insert(parts, part)
        end
        local desc = table.concat(parts, " or ")
        desc = (key:sub(1, 1) == "a" and "Around " or "Inside ") .. desc
        vim.keymap.set({ "x", "o" }, key, function()
          require("nvim-treesitter-textobjects.select").select_textobject(query, "textobjects")
        end, {
          buffer = buf,
          desc = desc,
          silent = true,
        })
      end
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    group = vim.api.nvim_create_augroup("lazyvim_treesitter_textobjects", { clear = true }),
    callback = function(ev)
      attach(ev.buf)
    end,
  })
  vim.tbl_map(attach, vim.api.nvim_list_bufs())
end
