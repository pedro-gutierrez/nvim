local cmp = require('cmp')

cmp.setup({
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-b>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true })
  }),
  sources = {
    { name = 'path' },
    { name = 'nvim_lsp',   keyword_length = 1 },
    { name = 'buffer',     keyword_length = 3 },
    { name = 'luasnip',    keyword_length = 2 },
    { name = 'treesitter', keyword_length = 3 }
  }
})
