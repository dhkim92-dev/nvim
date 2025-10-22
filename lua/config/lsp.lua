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

