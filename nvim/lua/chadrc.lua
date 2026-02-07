-- This file needs to have same structure as nvconfig.lua
-- https://github.com/NvChad/ui/blob/v3.0/lua/nvconfig.lua
-- Please read that file to know all available options :(

---@type ChadrcConfig
local M = {}

M.base46 = {
	theme = "bearded-arc",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

-- M.nvdash = { load_on_startup = true }
-- M.ui = {
--       tabufline = {
--          lazyload = false
--      }
-- }

M.term = {
  float = {
    width = 0.75,
    height = 0.6,
    row = (1 - 0.6) / 2 - 0.03,
    col = (1 - 0.75) / 2 - 0.01,
  }
}

return M
