--[[ local config = {
  cmd = { 
    vim.fn.expand("$HOME/.local/share/nvim/mason/bin/jdtls"),
    ('--jvm-arg=-javaagent:%s'):format(vim.fn.expand'$HOME/.local/share/nvim/mason/packages/jdtls/lombok.jar')
  },
  root_dir = vim.fs.dirname(vim.fs.find({ "mvnw", "build.gradle" }, { upward = true })[1]),
}

require("jdtls").start_or_attach(config) 
 ]]
