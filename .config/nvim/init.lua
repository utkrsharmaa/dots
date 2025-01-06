-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- To get filetype symbols
require("mini.icons")

require("mason").setup({
  PATH = "append",
})

-- Setup LSP for rust-analyzer
local lspconfig = require("lspconfig")

-- rust-analyzer configuration
lspconfig.rust_analyzer.setup({
  cmd = { "/home/krsh/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/rust-analyzer" }, -- Path to rust-analyzer binary
  filetypes = { "rust" },
  root_dir = lspconfig.util.root_pattern("Cargo.toml"),
  settings = {
    ["rust-analyzer"] = {
      diagnostics = {
        enable = true, -- Enable diagnostics from rust-analyzer
      },
      checkOnSave = {
        command = "clippy", -- Use clippy for linting
      },
      cargo = {
        allFeatures = true, -- Analyze with all Cargo features enabled
      },
      inlayHints = {
        enable = true, -- Enable inlay hints
        parameterHints = true,
        typeHints = true,
      },
    },
  },
})

-- Completion Plugin Setup
local cmp = require("cmp")
local lspkind = require("lspkind")
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  completion = {
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  preselect = "None",
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<C-S-f>"] = cmp.mapping.scroll_docs(-4),
    ["<C-f>"] = cmp.mapping.scroll_docs(4),
    ["<C-Space>"] = cmp.mapping.complete(),
    ["<C-e>"] = cmp.mapping.close(),
    ["<CR>"] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = false,
    }),
  },
  -- Installed sources:
  sources = {
    { name = "path" }, -- file paths
    { name = "nvim_lsp", keyword_length = 3 }, -- from language server
    { name = "nvim_lsp_signature_help" }, -- display function signatures with current parameter emphasized
    { name = "nvim_lua", keyword_length = 2 }, -- complete neovim's Lua runtime API such vim.lsp.*
    { name = "buffer", keyword_length = 2 }, -- source current buffer
    { name = "vsnip", keyword_length = 2 }, -- nvim-cmp source for vim-vsnip
    { name = "calc" }, -- source for math calculation
    { name = "crates" },
  },
  window = {
    completion = cmp.config.window.bordered(),
    documentation = cmp.config.window.bordered(),
  },
  formatting = {
    expandable_indicator = true,
    fields = { "kind", "abbr", "menu" },
    format = lspkind.cmp_format({
      before = function(entry, vim_item)
        vim_item.abbr = string.sub(vim_item.abbr, 1, 15)
        vim_item.menu = ""
        return vim_item
      end,
    }),
  },
})

-- LSP Diagnostics Options Setup
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = "",
  })
end

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  update_in_insert = true,
  underline = true,
  severity_sort = false,
  float = {
    border = "rounded",
    source = true,
    header = "Diagnostics",
    prefix = function(diagnostics)
      local diag_to_icon = {
        [vim.diagnostic.severity.ERROR] = " ",
        [vim.diagnostic.severity.WARN] = " ",
        [vim.diagnostic.severity.INFO] = "",
        [vim.diagnostic.severity.HINT] = " ",
      }
      return diag_to_icon[diagnostics.severity], ""
    end,
  },
})

sign({ name = "DiagnosticSignError", text = " " })
sign({ name = "DiagnosticSignWarn", text = " " })
sign({ name = "DiagnosticSignHint", text = "" })
sign({ name = "DiagnosticSignInfo", text = " " })
