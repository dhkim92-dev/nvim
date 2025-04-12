return {
  'Civitasv/cmake-tools.nvim',
  opt = {},
  config = function() 
    local config = require("config.cmake")
    require("cmake-tools").setup(config)
  end
}
