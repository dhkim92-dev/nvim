return {
  "kevalin/mermaid.nvim",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  ft = { "mermaid" },
  config = function()
    require("mermaid").setup({
      format = {
        shift_width = 4,
      },
      lint = {
        enabled = true,
        command = "mmdc",
      },
      preview = {
        renderer = "mermaid.js",
        theme = "default",
      },
    })
  end,
}
