return {
  'neovim/nvim-lspconfig',
  event = 'VeryLazy',
  dependencies = {
    { 'williamboman/mason.nvim' },
    { 'williamboman/mason-lspconfig.nvim' },
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' },
    { 'j-hui/fidget.nvim', opts = {} },
    { 'folke/neodev.nvim', opts = {} },
  },
  config = function ()
    
    require('mason').setup()
    require('mason-lspconfig').setup({
      -- Install these LSPs automatically
      ensure_installed = {
        'bashls',
        'lua_ls',
        'ts_ls',
        'pyright',
        'html',
        'clangd',
        'jsonls',
        -- 'cmake',
        'cssls',
        'rust_analyzer',
        'dockerls',
        'jdtls',
      }
    })

    require('mason-tool-installer').setup({
      ensure_installed = {
        'java-debug-adapter',
        'java-test',
        'kotlin-debug-adapter'
      },
      auto_update = true,
      run_on_start = true,
    })

    vim.api.nvim_command("MasonToolsInstall")

    local servers = require('mason-lspconfig').get_installed_servers()

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

    -- local lspconfig = require('lspconfig')
    local cmp_nvim_lsp = require('cmp_nvim_lsp')
    local lsp_capabilities = require('cmp_nvim_lsp').default_capabilities()

    local function on_attach(client, bufnr) 
    end



    for _, server_name in ipairs(servers) do
    -- jdtls는 제외
        if server_name ~= 'jdtls' then
            -- 기존 setup_handlers와 동일한 효과
            vim.lsp.config(server_name, {
                on_attach = on_attach,
                capabilities = lsp_capabilities,
            })
        end
    end

    -- lua
    start_lsp({ "lua-language-server" }, { "lua" })
    -- C/C++
    start_lsp({ "clangd" }, {"compile_commands.json", "CMakeLists.txt" })

    start_lsp({ "rust-analyzer" }, { "Cargo.toml" }, {
      ["rust-analyzer"] = {
        cargo = {
          allFeatures = true,
        },
      },
    })

    start_lsp({'kotlin-lsp'}, { "build.gradle.kts", "settings.gradle.kts" })
    vim.api.nvim_create_autocmd("VimLeavePre", {
      callback = function()
        local clients = vim.lsp.get_active_clients()
        for _, client in pairs(clients) do
          if client.name == "kotlin_lsp" then
            client.stop()
          end
        end
      end,
    })


    start_lsp({ "pyright" }, { "requirements.txt", vim.fn.getcwd() })

    local open_floating_preview = vim.lsp.util.open_floating_preview
    function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
      opts = opts or {}
      opts.border = opts.border or "rounded" -- Set border to rounded
      return open_floating_preview(contents, syntax, opts, ...)
    end

  end
}