require("config.lazy")

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

require("presence").setup({
  -- General options
  auto_update = true, -- Update activity based on autocmd events (if `false`, map or manually execute `:lua package.loaded.presence:update()`)
  main_image = "file", -- Main image display (either "neovim" or "file")
  enable_line_number = false, -- Displays the current line number instead of the current project
  debounce_timeout = 1, -- Number of seconds to debounce events (or calls to `:lua package.loaded.presence:update(<filename>, true)`)
  show_time = true, -- Show the timer
})
