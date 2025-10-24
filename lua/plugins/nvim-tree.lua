return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
      'nvim-tree/nvim-web-devicons',
  },
  opts = {
    actions = {
      open_file = {
        window_picker = {
          enable = false,
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
  },

  config = function(_, opts)
    vim.g.loaded_newrw = 1
    vim.g.loaded_newrwPlugin = 1
    require('nvim-tree').setup(opts)
  end,
}
