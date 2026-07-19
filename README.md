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
| **Neovim ≥ 0.11** | 본체 |
| **git** | 플러그인 clone (lazy.nvim) |
| **C 컴파일러** (clang/gcc) | Treesitter 파서 컴파일 (macOS는 `xcode-select --install`로 제공) |
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
| **Java / Spring 개발** | JDK 21 이상 (jdtls 구동용) |
| **한/영 입력기 표시 ([ime-status](https://github.com/s4ng/ime-status.nvim))** | macOS: `macism` · Linux: `ibus` 또는 `fcitx5-remote`(실험적) · Windows: 불필요(내장 FFI) — `:checkhealth ime-status`로 확인 |
| **클립보드 연동 (Linux)** | X11: `xclip`/`xsel`, Wayland: `wl-clipboard` |

### 설치 예시

**macOS (Homebrew)**

```bash
# 필수 + 권장
brew install neovim git ripgrep fd lazygit node
brew install --cask font-hack-nerd-font   # Nerd Font (설치 후 터미널 폰트로 지정)

# 기능별 (선택)
brew install laishulu/homebrew/macism      # ime-status: 한/영 표시 (⚠️ tap 경로 필수, `brew install macism`은 실패)
brew install openjdk                        # Java/Spring 개발 (JDK 21+)
```

**Linux (Debian/Ubuntu 예시)**

```bash
sudo apt install neovim git ripgrep fd-find nodejs npm build-essential xclip
# lazygit: 배포판 저장소 또는 https://github.com/jesseduffield/lazygit#installation 참고
# ime-status: ibus 또는 fcitx5 설치 후 :checkhealth ime-status
```

> 참고: Debian 계열은 `fd`가 `fdfind` 이름으로 설치됩니다. `ln -s $(which fdfind) ~/.local/bin/fd` 로 별칭을 만들어 두면 편합니다.

## Usage

[Windows](https://github.com/s4ng/lazy-vim-custom/blob/main/doc/README-Windows.md) | Mac or Linux

- 현재의 Nvim 설정을 백업하세요.

```bash
# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}
```

- Repository를 clone 하세요.

```bash
git clone https://github.com/s4ng/lazy-vim-custom ~/.config/nvim
```

- .git 디렉토리를 제거하세요.

```bash
rm -rf ~/.config/nvim/.git
```

- Neovim을 시작히세요.

```bash
nvim
```
