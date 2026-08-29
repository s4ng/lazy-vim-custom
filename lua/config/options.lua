-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = { "en_us", "cjk" }

-- 마크다운 등에서 ```코드블럭```, 링크 문법이 커서 위치에 따라 숨겨지지 않고
-- 항상 원본 그대로 표시되도록 conceal 비활성화 (LazyVim 기본값 2를 덮어씀)
vim.opt.conceallevel = 0

-- nvim-treesitter(main) 파서 빌드용 C 컴파일러.
-- tree-sitter CLI는 zig를 clang 계열로 감지하면 zig가 파싱하지 못하는 트리플을
-- 넘기고, `CC="zig cc"`처럼 공백이 들어가면 `cc` 서브커맨드를 잃어버린다.
-- 그래서 네이티브 컴파일러가 없고 zig만 있는 머신에서는 저장소에 내장된 래퍼를
-- CC로 지정한다 (자세한 이유는 scripts/zig-cc.ps1, scripts/zig-cc.sh 참고).
-- cl/cc/gcc/clang 중 하나라도 있으면 아무것도 하지 않는다.
if vim.fn.executable("zig") == 1 then
  local config = vim.fn.stdpath("config")
  if vim.fn.has("win32") == 1 then
    if vim.fn.executable("cl") == 0 then
      vim.env.CC = config .. "\\scripts\\zig-cc.cmd"
    end
  elseif vim.fn.executable("cc") == 0 and vim.fn.executable("gcc") == 0 and vim.fn.executable("clang") == 0 then
    vim.env.CC = config .. "/scripts/zig-cc.sh"
  end
end
