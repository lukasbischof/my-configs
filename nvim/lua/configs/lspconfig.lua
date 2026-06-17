require("nvchad.configs.lspconfig").defaults()

-- Configure LSP servers BEFORE enabling them
vim.lsp.config.cssls.cmd = { "mise", "exec", "node@25.2.1", "--", "vscode-css-language-server", "--stdio" }
vim.lsp.config.bashls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = nil,
}
vim.lsp.config.emmet_ls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "emmet-ls", "--stdio" },
  filetypes = {
    "astro",
    "eruby",
    "html",
    "htmlangular",
    "htmldjango",
    "javascriptreact",
    "pug",
    "svelte",
    "templ",
    "typescriptreact",
    "vue",
  },
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
vim.lsp.config.eslint.cmd = { "mise", "exec", "node@25.2.1", "--", "vscode-eslint-language-server", "--stdio" }
vim.lsp.config.ts_ls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "typescript-language-server", "--stdio" },
}
vim.lsp.config.stimulus_ls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "stimulus-language-server", "--stdio" },
}
vim.lsp.config.ruby_lsp = {
  init_options = {
    formatter = "auto",
    enabledFeatures = {
      codeActions = true,
      codeLens = true,
      completion = true,
      definition = true,
      diagnostics = true,
      documentHighlights = true,
      documentLink = true,
      documentSymbols = true,
      foldingRanges = true,
      formatting = true,
      hover = true,
      inlayHint = true,
      onTypeFormatting = true,
      selectionRanges = true,
      semanticHighlighting = true,
      signatureHelp = true,
      typeHierarchy = true,
      workspaceSymbol = true,
    },
    addonSettings = {
      ["Ruby LSP Rails"] = {
        enablePendingMigrationsPrompt = false,
      },
    },
  },
}
vim.lsp.config.jsonls = {
  cmd = { "mise", "exec", "node@25.2.1", "--", "vscode-json-language-server", "--stdio" },
  settings = {
    json = {
      validate = { enable = true },
      schemas = require("schemastore").json.schemas {
        extra = {
          {
            description = "Nono profile file",
            fileMatch = { "*nono/profiles/*.json" },
            url = "file:///Users/lukas/.config/nono/nono-profile.schema.json",
            name = "nono-profile",
          },
        },
      },
    },
  },
}

-- Rubocop diagnostics and code actions are handled by ruby_lsp's built-in
-- addon. Standardrb needs a standalone server because ruby_lsp's auto-detection
-- does not recognize Standard as a linter (upstream limitation).
local function has_standard_gem()
  local handle = io.popen "[ -f Gemfile ] && grep -q 'gem \"standard\"' Gemfile && echo 'true'"
  if not handle then
    return false
  end
  local result = handle:read "*a"
  handle:close()
  return result:match "true" ~= nil
end

if has_standard_gem() then
  -- Overwrite formatter to standard
  vim.lsp.config.ruby_lsp = vim.tbl_deep_extend("force", vim.lsp.config.ruby_lsp, {
    init_options = {
      formatter = "standard",
      linters = { "standard" },
    },
    addonSettings = {
      ["Rubocop"] = {
        enabled = false,
      },
    },
  })
end

local servers = {
  "bashls",
  "clangd",
  "cssls",
  "dartls",
  "emmet_ls",
  "eslint",
  "gopls",
  "hls",
  "html",
  "herb_ls",
  "jsonls",
  "lua_ls",
  "pyright",
  "ruby_lsp",
  "sourcekit",
  "stimulus_ls",
  "texlab",
  "ts_ls",
  "yamlls",
}

vim.lsp.enable(servers)
