require("nvchad.configs.lspconfig").defaults()

-- Function to check if standard gem is available
local function has_standard_gem()
  local handle = io.popen "grep -q 'gem \"standard\"' Gemfile && echo 'true'"
  if not handle then
    return false
  end
  local result = handle:read "*a"
  handle:close()
  return result:match "true" ~= nil
end

-- Configure LSP servers BEFORE enabling them
vim.lsp.config.cssls.cmd = { "mise", "exec", "node@25.2.1", "--", "vscode-css-language-server", "--stdio" }
vim.lsp.config.bashls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = nil,
}
vim.lsp.config.emmet_ls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "emmet-ls", "--stdio" },
  filetypes = { "astro", "eruby", "html", "htmlangular", "htmldjango", "javascriptreact", "pug", "svelte", "templ", "typescriptreact", "vue" },
}
vim.lsp.config.html = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "vscode-html-language-server", "--stdio" },
  filetypes = { "html", "templ", "eruby", "erb" },
  root_markers = { "package.json", ".git" },
  init_options = {
    configurationSection = { "html", "css", "javascript" },
    embeddedLanguages = {
      css = true,
      javascript = true,
    },
    provideFormatter = true,
  },
}
vim.lsp.config.herb_ls.cmd = { "mise", "exec", "node@25.2.1", "--", "herb-language-server", "--stdio" }

-- Configure standardrb LSP only if available
if has_standard_gem() then
  vim.lsp.config.standardrb = {
    cmd = { "bundle", "exec", "standardrb", "--lsp" },
    filetypes = { "ruby" },
    root_markers = { ".standard.yml" },
    single_file_support = false,
  }
else
  vim.lsp.config.rubocop = {
    cmd = { "bundle", "exec", "rubocop", "--lsp" },
    filetypes = { "ruby" },
    root_markers = { "Gemfile", ".rubocop.yml" },
  }
end

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "dartls",
  "emmet_ls",
  "gopls",
  "hls",
  "html",
  "herb_ls",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruby_lsp",
  "sourcekit",
  "texlab",
  "ts_ls",
}

-- Only add standardrb if standard gem is available, otherwise use rubocop
if has_standard_gem() then
  table.insert(servers, "standardrb")
else
  table.insert(servers, "rubocop")
end
vim.lsp.enable(servers)

-- vim.lsp.config.ruby_lsp.cmd = { "mise", "exec", "ruby@3.4.8", "--", "ruby-lsp" }

-- read :h vim.lsp.config for changing options of lsp servers
