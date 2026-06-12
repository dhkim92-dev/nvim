return {
  'neovim/nvim-lspconfig',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function()
    require('mason').setup()

    local mason_bin = vim.fn.stdpath('data') .. '/mason/bin'
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local function on_attach(client, bufnr)
      if client.name == 'kotlin_lsp' then
        vim.api.nvim_create_autocmd('BufWritePre', {
          buffer = bufnr,
          callback = function()
            vim.lsp.buf.format({ async = false })
          end,
        })
      end
    end

    vim.lsp.config('*', {
      capabilities = lsp_capabilities,
      on_attach = on_attach,
    })

    vim.lsp.config('lua_ls', {
      settings = {
        Lua = {
          diagnostics = {
            globals = { 'vim' },
          },
        },
      },
    })

    vim.lsp.config('clangd', {
      cmd = {
        'clangd',
        '--background-index',
        '--clang-tidy',
        '--header-insertion=never',
      },
      root_markers = {
        '.clangd',
        'compile_commands.json',
        'compile_flags.txt',
        'CMakeLists.txt',
        '.git',
      },
    })

    vim.lsp.config('pyright', {
      root_markers = {
        'pyproject.toml',
        'setup.py',
        'setup.cfg',
        'requirements.txt',
        'Pipfile',
        'pyrightconfig.json',
        '.git',
      },
    })

   --[[  
    local function kotlin_root(bufnr, on_dir)
      local fname = vim.api.nvim_buf_get_name(bufnr)
      local dir = vim.fs.dirname(fname)

      local root = vim.fs.root(dir, {
        'settings.gradle.kts',
        'settings.gradle',
      })

      if root then
        on_dir(root)
      end
    end

    vim.lsp.config('kotlin_lsp', {
      cmd = { mason_bin .. '/intellij-server', '--stdio' },
      filetypes = { 'kotlin' },
      root_dir = kotlin_root,

      settings = {
        ['intellij.buildTool'] = 'gradle',
        ['intellij.trace.server'] = 'verbose',
      },
     ]]})

    require('mason-lspconfig').setup({
      ensure_installed = {
        'bashls',
        'lua_ls',
        'ts_ls',
        'pyright',
        'html',
        'clangd',
        'jsonls',
        'cssls',
        'rust_analyzer',
        'dockerls',
        'jdtls',
        'kotlin_lsp',
      },
      automatic_enable = {
        exclude = {
          'jdtls',
          'kotlin_lsp',
        },
      },
    })

    -- 반드시 config 정의 이후에 실행
    -- vim.lsp.enable('kotlin_lsp')

    require('mason-tool-installer').setup({
      ensure_installed = {
        'java-debug-adapter',
        'java-test',
        'kotlin-debug-adapter',
      },
      auto_update = true,
      run_on_start = true,
    })

    local open_floating_preview = vim.lsp.util.open_floating_preview

    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or 'rounded'
      return open_floating_preview(contents, syntax, opts, ...)
    end
  end,
}
