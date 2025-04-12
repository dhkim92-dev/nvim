return {
  { 
    "williamboman/mason.nvim",
    config = function()
      local config = require("config.mason")
      require("mason").setup(config)
    end
  },
  { 
    "williamboman/mason-lspconfig.nvim",
    config = function()
      local config = require("config.mason-lspconfig")
      require("mason-lspconfig").setup(config)
    end
  }
}

