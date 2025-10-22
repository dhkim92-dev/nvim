--[[ local cmp = require('cmp')
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
-- local lspconfig = vim.lsp
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    has_cmp and cmp_nvim_lsp.default_capabilities() or {}
)

lspconfig.clangd.setup{}
lspconfig.rust_analyzer.setup {
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
--lspconfig.kotlin_lsp.setup{} ]]
--
-- ========================
--  nvim-cmp + LuaSnip 설정
-- ========================
local cmp = require('cmp')
local luasnip = require('luasnip')

cmp.setup({
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.abort(),
    ['<CR>'] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = 'nvim_lsp' },
    { name = 'buffer' },
    { name = 'path' },
    { name = 'luasnip' },
  },
})

require('luasnip.loaders.from_vscode').lazy_load()


-- ========================
--  공통 capability 설정
-- ========================
local capabilities = vim.lsp.protocol.make_client_capabilities()
local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if has_cmp then
  capabilities = vim.tbl_deep_extend(
    "force",
    capabilities,
    cmp_nvim_lsp.default_capabilities()
  )
end

-- ========================
--  on_attach 공통 설정
-- ========================
local function on_attach(client, bufnr)
  local opts = { noremap = true, silent = true, buffer = bufnr }
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
end


-- ========================
--  LSP 서버별 설정 (신규 방식)
-- ========================
local function start_lsp(cmd, root_patterns, settings)
  local root_dir = vim.fs.root(0, root_patterns)
  if not root_dir then return end
  vim.lsp.start({
    cmd = cmd,
    root_dir = root_dir,
    capabilities = capabilities,
    on_attach = on_attach,
    settings = settings or {},
  })
end

-- C/C++
start_lsp({ "clangd" }, { ".git", "compile_commands.json" })

-- Rust
start_lsp({ "rust-analyzer" }, { "Cargo.toml" }, {
  ["rust-analyzer"] = {
    checkOnSave = { command = "clippy" },
    assist = { importGranularity = "module", importPrefix = "by_self" },
    completion = { postfix = { enable = true } },
    cargo = { loadOutDirsFromCheck = true },
    procMacro = { enable = true },
    diagnostics = { disabled = { "unresolved-proc-macro" } },
  },
})

-- TypeScript / JavaScript
start_lsp({ "typescript-language-server", "--stdio" }, { "package.json", "tsconfig.json" })

-- Python
start_lsp({ "pyright-langserver", "--stdio" }, { "pyproject.toml", "setup.py" })

-- Kotlin (설치되어 있다면)
start_lsp({ "kotlin-language-server" }, { "build.gradle.kts", "build.gradle" })

