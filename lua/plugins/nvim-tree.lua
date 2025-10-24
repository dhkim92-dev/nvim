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
    },

    config = function(_, opts)
        vim.g.loaded_newrw = 1
        vim.g.loaded_newrwPlugin = 1
        require('nvim-tree').setup(opts)
    end,
}