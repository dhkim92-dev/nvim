return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons',
    'folke/snacks.nvim',
    "folke/noice.nvim",
  },
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = true,
        },
      },
    },
    renderer = {
      group_empty = true,
      indent_markers = {
        enable = true,
      },
      root_folder_label = ":t",
    },
    view = {
      width = 35,
      side = 'left',
    },
    filters = {
      dotfiles = false
    },
    git = {
      enable = true,
      ignore = false, -- Set to false to show git-ignored files/directories
      timeout = 500,
    },
  },

  config = function(_, opts)
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    pcall(require, 'dressing')
    pcall(require, 'noice')
    require('nvim-tree').setup(opts)
  end,
}
