-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.spelllang = { "en_us", "cjk" }

-- 마크다운 등에서 ```코드블럭```, 링크 문법이 커서 위치에 따라 숨겨지지 않고
-- 항상 원본 그대로 표시되도록 conceal 비활성화 (LazyVim 기본값 2를 덮어씀)
vim.opt.conceallevel = 0
