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

    -- lualine 은 자체 타이머(refresh.statusline, 1000ms)와 "User" 가 들어 있지 않은
    -- 고정 이벤트 목록으로만 다시 그린다. 그래서 라벨이 바뀔 때 ime-status 가 보내는
    -- redrawstatus 가 닿지 않고, 커서를 움직이지 않은 채 한/영만 누르면 최대 1초까지
    -- 직전 라벨이 그대로 남는다. 변경 이벤트에서 직접 갱신시킨다.
    vim.api.nvim_create_autocmd("User", {
      pattern = "IMEStatusChanged",
      callback = function()
        require("lualine").refresh({ place = { "statusline" } })
      end,
    })
  end,
}
