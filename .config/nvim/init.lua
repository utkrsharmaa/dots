require("config.lazy")

vim.g.rustaceanvim = {
  server = {
    root_dir = vim.fn.getcwd(),
    settings = {
      ["rust-analyzer"] = {
        rustc = {
          source = "discover",
        },
        -- linkedprojects = {
        --  "./cargo.toml",
        --  "clippy_dev/cargo.toml",
        --  "lintcheck/cargo.toml",
        -- },
      },
    },
  },
}
-- Completion Plugin Setup
local cmp = require("cmp")
local lspkind = require("lspkind")
local luasnip = require("luasnip")
cmp.setup({
  -- Enable LSP snippets
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end,
  },
  completion = {
    completeopt = table.concat(vim.opt.completeopt:get(), ","),
  },
  preselect = cmp.PreselectMode.None,
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),
    -- Add tab support
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.locally_jumpable(1) then
        luasnip.jump(1)
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.locally_jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
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
    { name = "nvim_lsp" },
    { name = "nvim_lsp_signature_help" },
    { name = "luasnip" },
    { name = "buffer" },
    { name = "nvim_lua" },
    { name = "path" },
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
        vim_item.menu = string.sub(vim_item.abbr, 1, 15)
        return vim_item
      end,
    }),
  },
})

-- treesitter
require("nvim-treesitter.configs").setup({
  ensure_installed = { "lua", "rust", "toml" },
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  ident = { enable = true },
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  },
})
