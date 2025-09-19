return {
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "williamboman/mason.nvim", "mfussenegger/nvim-dap" },
    config = function()
      -- ask mason-nvim-dap to ensure typical java debug adapter is available
      require("mason-nvim-dap").setup({
        ensure_installed = { "java-debug-adapter" },
        automatic_setup = true,
      })
    end,
  },

  -- nvim-dap core
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- small default: open terminal in a vertical split when needed
      dap.defaults.fallback.terminal_win_cmd = "50vsplit new"
    end,
  },

  -- dap UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end
    end,
  },

  -- jdtls (Eclipse JDT Language Server wrapper) - used for Java/Kotlin JVM projects
  {
    "mfussenegger/nvim-jdtls",
    ft = { "java", "kotlin" },
    dependencies = { "mfussenegger/nvim-dap", "rcarriga/nvim-dap-ui" },
    config = function()
      -- this config runs when a Java/Kotlin file is opened
      local jdtls_ok, jdtls = pcall(require, "jdtls")
      if not jdtls_ok then
        vim.notify("nvim-jdtls not available", vim.log.levels.WARN)
        return
      end

      -- try to autodiscover java-debug & java-test jars from mason
      local function gather_bundles()
        local bundles = {}
        local mason_share = vim.fn.expand("$MASON/share/java-debug-adapter/com.microsoft.java.debug.plugin-*.jar")
        if mason_share and mason_share ~= "" then
          for _, f in ipairs(vim.split(vim.fn.glob(mason_share), "\n")) do
            if f ~= "" then table.insert(bundles, f) end
          end
        end

        local mason_pkg_glob = vim.fn.stdpath("data") .. "/mason/packages/java-debug-adapter/**/com.microsoft.java.debug.plugin-*.jar"
        for _, f in ipairs(vim.fn.glob(mason_pkg_glob, true, true)) do
          if f and f ~= "" then table.insert(bundles, f) end
        end

        -- java-test server jars (optional, for test debugging)
        local java_test_glob = vim.fn.stdpath("data") .. "/mason/packages/java-test/**/server/*.jar"
        for _, f in ipairs(vim.fn.glob(java_test_glob, true, true)) do
          if f and f ~= "" then table.insert(bundles, f) end
        end

        return bundles
      end

      local bundles = gather_bundles()

      local config = {
        cmd = { vim.fn.exepath("jdtls") },
        root_dir = function(fname)
          return vim.fs.root(fname, { 'gradlew', 'pom.xml', '.git' })
        end,
        init_options = {
          bundles = bundles,
        },
        settings = {
          java = {},
        },
      }

      -- start or attach jdtls for the project
      jdtls.start_or_attach(config)

      -- register DAP integration if bundles exist (java-debug-adapter / java-test)
      if #bundles > 0 then
        -- this registers the java adapter for nvim-dap
        require('jdtls').setup_dap({ hotcodereplace = 'auto' })
        -- (optional) gather main-class configs so you can launch main classes
        pcall(require, 'jdtls.dap').setup_dap_main_class_configs()
      end

      -- fallback / helpful DAP configurations (attach to remote JVM) useful for Spring Boot
      local dap = require('dap')
      dap.configurations.java = {
        {
          type = 'java',
          request = 'attach',
          name = 'Attach to remote JVM (localhost:5005)',
          hostName = '127.0.0.1',
          port = 5005,
        },
      }
      dap.configurations.kotlin = dap.configurations.java

      -- some convenient keymaps (you can change these)
      local map = vim.keymap.set
      map('n', '<F5>', function() require('dap').continue() end, { silent = true, desc = 'DAP: Continue' })
      map('n', '<F10>', function() require('dap').step_over() end, { desc = 'DAP: Step Over' })
      map('n', '<F11>', function() require('dap').step_into() end, { desc = 'DAP: Step Into' })
      map('n', '<F12>', function() require('dap').step_out() end, { desc = 'DAP: Step Out' })
      map('n', '<Leader>b', function() require('dap').toggle_breakpoint() end, { desc = 'DAP: Toggle Breakpoint' })
      map('n', '<Leader>B', function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, { desc = 'DAP: Conditional Breakpoint' })
    end,
  },
}

