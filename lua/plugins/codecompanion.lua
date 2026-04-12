return {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    -- Test with blink.cmp
    {
      "saghen/blink.cmp",
      version = "1.*",
      opts = {
        keymap = {
          preset = "enter",
          ["<S-Tab>"] = { "select_prev", "fallback" },
          ["<Tab>"] = { "select_next", "fallback" },
        },
        cmdline = { sources = { "cmdline" } },
        sources = {
          default = { "lsp", "path", "buffer", "codecompanion" },
        },
      },
    },
  },

  opts = {
    interactions = {
      chat = {
        adapter = {
          name = 'copilot',
          model = 'gpt-5-mini',
        },
        keymaps = {
                  options = {
          modes = { n = "?" },
          callback = "keymaps.options",
          description = "Options",
          hide = true,
        },
        completion = {
          modes = { i = "<C-_>" },
          index = 1,
          callback = "keymaps.completion",
          description = "[Chat] Completion menu",
        },
        send = {
          modes = {
            n = { "<CR>", "<C-s>" },
            i = "<C-s>",
          },
          index = 2,
          callback = "keymaps.send",
          description = "[Request] Send response",
        },
        regenerate = {
          modes = { n = "ar" },
          index = 3,
          callback = "keymaps.regenerate",
          description = "[Request] Regenerate",
        },
        close = {
          modes = {
            n = "<C-c>",
            i = "<C-c>",
          },
          index = 4,
          callback = "keymaps.close",
          description = "[Chat] Close",
        },
        stop = {
          modes = { n = "q" },
          index = 5,
          callback = "keymaps.stop",
          description = "[Request] Stop",
        },
        clear = {
          modes = { n = "ax" },
          index = 6,
          callback = "keymaps.clear",
          description = "[Chat] Clear",
        },
        codeblock = {
          modes = { n = "acb" },
          index = 7,
          callback = "keymaps.codeblock",
          description = "[Chat] Insert codeblock",
        },
        yank_code = {
          modes = { n = "ay" },
          index = 8,
          callback = "keymaps.yank_code",
          description = "[Chat] Yank code",
        },
        buffer_sync_all = {
          modes = { n = "abs" },
          index = 9,
          callback = "keymaps.buffer_sync_all",
          description = "[Chat] Toggle buffer syncing",
        },
        buffer_sync_diff = {
          modes = { n = "abd" },
          index = 10,
          callback = "keymaps.buffer_sync_diff",
          description = "[Chat] Toggle buffer diff syncing",
        },
        next_chat = {
          modes = { n = "}" },
          index = 11,
          callback = "keymaps.next_chat",
          description = "[Nav] Next chat",
        },
        previous_chat = {
          modes = { n = "{" },
          index = 12,
          callback = "keymaps.previous_chat",
          description = "[Nav] Previous chat",
        },
        next_header = {
          modes = { n = "]]" },
          index = 13,
          callback = "keymaps.next_header",
          description = "[Nav] Next header",
        },
        previous_header = {
          modes = { n = "[[" },
          index = 14,
          callback = "keymaps.previous_header",
          description = "[Nav] Previous header",
        },
        change_adapter = {
          modes = { n = "a?" },
          index = 15,
          callback = "keymaps.change_adapter",
          description = "[Adapter] Change adapter and model",
        },
        fold_code = {
          modes = { n = "af" },
          index = 15,
          callback = "keymaps.fold_code",
          description = "[Chat] Fold code",
        },
        debug = {
          modes = { n = "ad" },
          index = 16,
          callback = "keymaps.debug",
          description = "[Chat] View debug info",
        },
        system_prompt = {
          modes = { n = "asp" },
          index = 17,
          callback = "keymaps.toggle_system_prompt",
          description = "[Chat] Toggle system prompt",
        },
        rules = {
          modes = { n = "aR" },
          index = 18,
          callback = "keymaps.clear_rules",
          description = "[Chat] Clear Rules",
        },
        clear_approvals = {
          modes = { n = "gtx" },
          index = 19,
          callback = "keymaps.clear_approvals",
          description = "[Tools] Clear approvals",
        },
        yolo_mode = {
          modes = { n = "gty" },
          index = 20,
          callback = "keymaps.yolo_mode",
          description = "[Tools] Toggle YOLO mode",
        },
        goto_file_under_cursor = {
          modes = { n = "gR" },
          index = 21,
          callback = "keymaps.goto_file_under_cursor",
          description = "[Chat] Open file under cursor",
        },
        copilot_stats = {
          modes = { n = "gS" },
          index = 22,
          callback = "keymaps.copilot_stats",
          description = "[Adapter] Copilot statistics",
        },
        },
      }

    }, 
    opts = {
      log_level = "DEBUG"
    }
  }
}

