--require("CopilotChat").setup("config.copilot-chat")
return {
  { "github/copilot.vim" },
--[[   {
    "CopilotC-Nvim/CopilotChat.nvim",
    config = function()
      require("CopilotChat").setup(require("config.copilot-chat"))
    end,

    dependencies = {
      { "github/copilot.vim" }, -- or zbirenbaum/copilot.lua
      { "nvim-lua/plenary.nvim", branch = "master" }, -- for curl, log and async functions
    },
    build = "make tiktoken", -- Only on MacOS or Linux
    opts = 
    {
      view = 
      {
        side = "right"
      },
      -- See Configuration section for options
      prompts = 
      {
        Rename = 
        {
          prompt = "Please rename the variable correctly in given section based on context",
          section = function(source) 
            local select = require('CopilotChat.select')
            return select.visual(source)
          end,
        },
      },
    },
  } ]]
}

