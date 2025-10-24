-- ~/.config/nvim/lua/config/treesitter.lua
require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "lua", "javascript", "typescript", "python", "rust", 
    "json", "html", "css",
    "kotlin", "java" -- ✅ Kotlin, Java 추가
  },
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
}

