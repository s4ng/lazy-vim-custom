-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = { "en_us", "cjk" }

-- 마크다운 등에서 ```코드블럭```, 링크 문법이 커서 위치에 따라 숨겨지지 않고
-- 항상 원본 그대로 표시되도록 conceal 비활성화 (LazyVim 기본값 2를 덮어씀)
vim.opt.conceallevel = 0

-- nvim-treesitter(main) 파서 빌드용 C 컴파일러 (Windows 전용 보정).
-- tree-sitter CLI는 Windows에서 MSVC(cl.exe)를 기본으로 찾으므로, MSVC가
-- 없고 zig가 있는 환경에서만 저장소에 내장된 zig cc 래퍼를 지정한다
-- (왜 래퍼가 필요한지는 scripts/zig-cc.ps1 참고). 다른 OS나 MSVC가 있는
-- 머신에는 아무 영향이 없다.
if vim.fn.has("win32") == 1 and vim.fn.executable("cl") == 0 and vim.fn.executable("zig") == 1 then
  vim.env.CC = vim.fn.stdpath("config") .. "\\scripts\\zig-cc.cmd"
end
