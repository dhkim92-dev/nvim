return {
    'nvim-treesitter/nvim-treesitter',
    event = 'VeryLazy',
    dependencies = {
        'nvim-treesitter/nvim-treesitter-textobjects',
    },
    build = ':TSUpdate',
    opts = {
        highlght = {
            enable = true,
        },
        indent = {
            enable = true,
        },
        auto_install = true,
        ensure_installed = {
            'lua',
            'comment',
            'java',
            'typescript',
            'kotlin',
            'json',
            'dockerfile',
            'yaml',
            'html',
            'css',
            'markdown',
            'cpp',
            'c',
            'bash',
            'python',
            'rust'
        },
    },

    config = function(_, opts)
        require('nvim-treesitter.configs').setup(opts)
    end,
}
