vim.opt.fixendofline = true
vim.opt.colorcolumn = "100,120"

-- Visual Multi mappings
vim.g.VM_maps = {
  ["Find Under"] = "<M-n>",
  ["Find Subword Under"] = "<M-n>",
  ["Add Cursor Up"] = "<M-k>",
  ["Add Cursor Down"] = "<M-j>"
}

-- Abbreviations
vim.cmd [[
  abbrev rials rails
  abbrev raisl rails
  abbrev ralis rails
  iabbrev teh the
  iabbrev enend end
]]
