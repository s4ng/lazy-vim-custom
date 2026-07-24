# 💤 LazyVim 

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

s4ng custom

## Pre-requirements

플러그인 매니저(lazy.nvim)는 git 저장소만 관리하고 **시스템 CLI/바이너리는 직접 설치**해야 합니다.
설치 후 `nvim`에서 `:checkhealth`로 누락된 의존성을 확인할 수 있습니다.

### 필수

| 도구 | 용도 |
|---|---|
| **Neovim ≥ 0.11.2** | LazyVim 최신 버전의 최소 요구사항 |
| **git** | 플러그인 clone (lazy.nvim) |
| **C 컴파일러** (zig / LLVM / MSVC) | Treesitter 파서 컴파일 (Windows에선 `zig` 권장) |
| **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md)** | Treesitter 파서 설치/업데이트 |
| **[ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)** | 텍스트 검색 (fzf-lua) |
| **[Nerd Font](https://www.nerdfonts.com/)** | 아이콘 표시 (터미널 폰트로 지정) |

### 권장

| 도구 | 용도 |
|---|---|
| **[fd](https://github.com/sharkdp/fd)** | 빠른 파일 검색 |
| **[lazygit](https://github.com/jesseduffield/lazygit)** | Git UI (`<leader>gg`) |
| **Node.js (npm)** | 일부 LSP · mason 도구(markdownlint 등) · markdown-preview |

### 기능별 (해당 기능을 쓸 때만)

| 기능 | 필요한 것 |
|---|---|
| **한/영 입력기 표시 ([ime-status](https://github.com/s4ng/ime-status.nvim))** | 불필요 — 내장 FFI 백엔드로 동작. `:checkhealth ime-status`로 확인 |

### 설치 예시 (scoop)

```powershell
# 필수 + 권장
scoop install neovim git ripgrep fd lazygit nodejs
scoop install zig            # Treesitter 파서 컴파일용 C 컴파일러
scoop install tree-sitter    # Treesitter 파서 설치/업데이트용 CLI
```

- **Nerd Font**: [nerdfonts.com](https://www.nerdfonts.com/)에서 폰트를 설치한 뒤 사용하는 터미널(Windows Terminal 등)의 폰트로 지정하세요.
- **zig** (Treesitter): MSVC가 없는 머신에서는 저장소에 내장된 래퍼(`scripts/zig-cc.cmd`)가 자동으로 사용되므로 zig만 설치하면 됩니다. MSVC(cl.exe)가 이미 있다면 zig 없이도 동작합니다.
- winget을 선호하면 `winget install Neovim.Neovim BurntSushi.ripgrep.MSVC sharkdp.fd JesseDuffield.lazygit OpenJS.NodeJS` 등으로 대체할 수 있습니다.

## Usage

Windows | [Mac or Linux](https://github.com/s4ng/lazy-vim-custom)

- 현재의 Nvim 설정을 백업하세요.

```
# required
Move-Item $env:LOCALAPPDATA\nvim $env:LOCALAPPDATA\nvim.bak

# optional but recommended
Move-Item $env:LOCALAPPDATA\nvim-data $env:LOCALAPPDATA\nvim-data.bak
```

- Repository를 clone 하세요.

```
git clone https://github.com/s4ng/lazy-vim-custom $env:LOCALAPPDATA\nvim

```

- Neovim을 시작하세요.

```
nvim
```

## Update and verification

설정 저장소를 유지한 채 최신화하려면 PowerShell에서 다음을 실행하세요.

```powershell
Set-Location $env:LOCALAPPDATA\nvim
git pull --ff-only
nvim
```

Neovim 안에서 `:Lazy update`를 실행한 뒤 재시작하고, `:checkhealth` 및 `:TSUpdate`를
실행하세요. Tree-sitter CLI가 없으면 파서 설치가 실패합니다.
