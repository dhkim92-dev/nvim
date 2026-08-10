return {
  {
    "milanglacier/minuet-ai.nvim",

    config = function()
      require("minuet").setup({
        -- 로컬 OpenAI-compatible FIM 서버
        provider = "openai_fim_compatible",

        -- 서버 context = 4096
        -- 출력 및 프롬프트 여유분 확보
        context_window = 3072,

        provider_options = {
          openai_fim_compatible = {
            name = "Local Llama",

            -- 로컬 LLM 서버
            end_point = "http://127.0.0.1:9931/v1/completions",

            -- Minuet 설정상 API key 환경변수 지정
            -- 로컬 서버에서 인증하지 않는 경우 placeholder 용도
            api_key = "TERM",

            -- 서버에서 모델이 이미 지정되어 있는 경우
            model = "PLACEHOLDER",

            stream = true,

            optional = {
              -- 자동완성 최대 생성량
              max_tokens = 1024,
              top_p = 0.9,
            },
          },
        },

        virtualtext = {
          -- 아래 파일에서는 입력 시 자동으로 AI completion 요청
          auto_trigger_ft = {
            "c",
            "cpp",
            "java",
            "kotlin",
            "lua",
            "python",
            "go",
            "rust",
            "typescript",
            "typescriptreact",
            "javascript",
            "javascriptreact",
          },

          keymap = {
            -- 전체 completion 적용
            accept = "<A-l>",

            -- 현재 줄만 적용
            accept_line = "<A-j>",

            -- 이전/다음 completion
            prev = "<A-[>",
            next = "<A-]>",

            -- completion 닫기
            dismiss = "<A-e>",
          },
        },
      })
    end,
  },
}
