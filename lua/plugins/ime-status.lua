return {
  "nvim-lualine/lualine.nvim",
  -- 퍼블리시된 배포본 사용. 로컬에서 플러그인을 수정하며 테스트하려면
  -- 아래 줄을 { dir = vim.fn.expand("~/ime-status.nvim") } 로 바꾸세요.
  dependencies = {
    "s4ng/ime-status.nvim",
  },
  opts = function(_, opts)
    require("ime-status").setup({
      auto_switch = true, -- 노멀 모드 = 항상 영문 → j/k가 ㅓ/ㅏ로 입력되는 문제 해결
      pause_on_focus_lost = true, -- 비포커스 시 폴링 정지 (배터리 절약)
    })
    -- lualine_x 맨 앞에 현재 입력기 표시를 추가
    table.insert(opts.sections.lualine_x, 1, { require("ime-status").component })
  end,
}
