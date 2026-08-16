return {
  "oclay1st/gradle.nvim",
  cmd = { "Gradle", "GradleExec", "GradleInit", "GradleFavorites" },
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  keys = {
    {
      "<leader>Gg",
      "<cmd>Gradle<cr>",
      desc = "Gradle 작업 목록 토글",
    },
    {
      "<leader>Gf",
      "<cmd>GradleFavorites<cr>",
      desc = "Gradle 즐겨찾기",
    },
  },
  opts = {
    -- 전역 Gradle 설치 대신, 프로젝트에 포함된 Gradle Wrapper를 사용합니다.
    gradle_executable = "./gradlew",
    projects_view = {
      position = "right",
      size = 65,
      open_in_tabpage = false,
    },
    console = {
      -- 현재 Neovim 버전과 호환되는 별도 split 창에 실행 결과를 표시합니다.
      open_in_tabpage = false,
      -- Task 목록을 불러오지 못했을 때 Gradle의 실제 오류를 콘솔에 표시합니다.
      show_tasks_load_execution = true,
    },
  },
}
