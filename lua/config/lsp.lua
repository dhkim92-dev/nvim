local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)  -- LuaSnip 확장
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),  -- 이전 항목 선택
    ['<C-n>'] = cmp.mapping.select_next_item(),  -- 다음 항목 선택
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),  -- 문서 위로 스크롤
    ['<C-f>'] = cmp.mapping.scroll_docs(4),  -- 문서 아래로 스크롤
    ['<C-Space>'] = cmp.mapping.complete(),  -- 자동완성 호출
    ['<C-e>'] = cmp.mapping.abort(),  -- 자동완성 종료
    ['<CR>'] = cmp.mapping.confirm({ select = true }),  -- 선택된 항목 확정
  },
  sources = {
    { name = 'nvim_lsp' },  -- LSP에서 자동 완성
    { name = 'buffer' },  -- 버퍼에서 자동 완성
    { name = 'path' },  -- 파일 경로에서 자동 완성
    { name = 'luasnip' },  -- LuaSnip에서 자동 완성
  },
})

local luasnip = require('luasnip')

-- 스니펫 로딩 예시 (다양한 스니펫 추가 가능)
require('luasnip.loaders.from_vscode').load()


-- LSP 서버 설정
local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
)


lspconfig.clangd.setup{}
require'lspconfig'.rust_analyzer.setup{
    on_attach = on_attach,
    capabilities = capabilities,
    settings = {
        ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
            assist = {
                importGranularity = "module",
                importPrefix = "by_self",
            },
            completion = {
                authimport=true,
                postfix={enable=true}
            },
            cargo = {
                loadOutDirsFromCheck = true
            },
            procMacro = {
                enable = true
            },
            diagnostics = {
                disabled = { "unresolved-proc-macro" } -- 혹시 필요한 경우
            }
        }
    }
}

lspconfig.ts_ls.setup{}
lspconfig.pyright.setup{} 

lspconfig.kotlin_language_server.setup({
  cmd = { "kotlin-language-server" },
  filetypes = { "kotlin" },
  root_dir = lspconfig.util.root_pattern("settings.gradle.kts", "build.gradle.kts", ".git"),
  capabilities = require("cmp_nvim_lsp").default_capabilities(),
})
