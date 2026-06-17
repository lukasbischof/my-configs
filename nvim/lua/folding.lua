vim.opt.foldenable = true
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.opt.foldlevelstart = 99

vim.api.nvim_create_autocmd("FileType", {
  pattern = "svelte",
  callback = function()
    vim.cmd [[
      function! SvelteFolds()
        let thisline = getline(v:lnum)
        if thisline =~? '\v^\s*$'
          return '-1'
        endif

        if thisline =~ '^\s*import.*$'
          return 2
        else
          return indent(v:lnum) / &shiftwidth
        endif
      endfunction
    ]]
    vim.opt.foldexpr = "SvelteFolds()"
  end,
})

local indent_fold_fts = { "yaml", "yml", "json", "html", "eruby", "css", "scss", "less" }

vim.api.nvim_create_autocmd("FileType", {
  pattern = indent_fold_fts,
  callback = function()
    vim.opt_local.foldmethod = "indent"
  end,
})

-- -- Set foldmethod to indent when opening a file
-- -- and set it to manual after entering a buffer
-- vim.cmd(string.format([[
--   augroup vimrc
--     au BufWinEnter * if &fdm == 'indent' && index(%s, &ft) == -1 | setlocal foldmethod=manual | endif
--   augroup END
-- ]], "['" .. table.concat(indent_fold_fts, "', '") .. "']"))
