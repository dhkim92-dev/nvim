-- local luasnip = require('luasnip')
-- local cmp = require('cmp')

return {
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)  -- LuaSnip 확장
    end,
  },
  mapping = {
    ['<C-p>'] = require('cmp').mapping.select_prev_item(),  -- 이전 항목 선택
    ['<C-n>'] = require('cmp').mapping.select_next_item(),  -- 다음 항목 선택
    ['<C-d>'] = require('cmp').mapping.scroll_docs(-4),  -- 문서 위로 스크롤
    ['<C-f>'] = require('cmp').mapping.scroll_docs(4),  -- 문서 아래로 스크롤
    ['<C-Space>'] = require('cmp').mapping.complete(),  -- 자동완성 호출
    ['<C-e>'] = require('cmp').mapping.abort(),  -- 자동완성 종료
    ['<CR>'] = require('cmp').mapping.confirm({ select = true }),  -- 선택된 항목 확정
  },
  sources = {
    { name = 'nvim_lsp' },  -- LSP에서 자동 완성
    { name = 'buffer' },  -- 버퍼에서 자동 완성
    { name = 'path' },  -- 파일 경로에서 자동 완성
    { name = 'luasnip' },  -- LuaSnip에서 자동 완성
  },
}

