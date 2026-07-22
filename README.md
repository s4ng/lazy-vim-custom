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
| **C 컴파일러** (clang/gcc) | Treesitter 파서 컴파일 (macOS는 `xcode-select --install`로 제공) |
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
| **Java / Spring 개발** | JDK 21 이상 (jdtls 구동용) |
| **한/영 입력기 표시 ([ime-status](https://github.com/s4ng/ime-status.nvim))** | macOS: `macism` · Linux: `ibus` 또는 `fcitx5-remote`(실험적) · Windows: 불필요(내장 FFI) — `:checkhealth ime-status`로 확인 |
| **클립보드 연동 (Linux)** | X11: `xclip`/`xsel`, Wayland: `wl-clipboard` |

### 설치 예시

**macOS (Homebrew)**

```bash
# 필수 + 권장
brew install neovim git ripgrep fd lazygit node tree-sitter-cli
brew install --cask font-hack-nerd-font   # Nerd Font (설치 후 터미널 폰트로 지정)

# 기능별 (선택)
brew install laishulu/homebrew/macism      # ime-status: 한/영 표시 (⚠️ tap 경로 필수, `brew install macism`은 실패)
brew install openjdk                        # Java/Spring 개발 (JDK 21+)
```

**Linux (Debian/Ubuntu 예시)**

```bash
sudo apt install git ripgrep fd-find nodejs npm build-essential tree-sitter-cli xclip
# lazygit: 배포판 저장소 또는 https://github.com/jesseduffield/lazygit#installation 참고
# ime-status: ibus 또는 fcitx5 설치 후 :checkhealth ime-status
```

> Neovim은 0.11 이상을 별도로 설치하세요. Debian/Ubuntu 기본 저장소의 `neovim`
> 패키지는 배포판 버전에 따라 너무 오래된 버전일 수 있습니다.
> `nvim --version`으로 실제 버전을 먼저 확인하세요.

> 참고: Debian 계열은 `fd`가 `fdfind` 이름으로 설치됩니다. `ln -s $(which fdfind) ~/.local/bin/fd` 로 별칭을 만들어 두면 편합니다.

### Linux 런타임 경로 오류

아래처럼 `module 'vim.uri' not found` 또는 `syntax/syntax.vim` 오류가 나면
설정보다 Neovim 본체의 런타임 경로가 깨진 상태일 가능성이 큽니다.
Neovim 0.12.x에서도 같은 오류가 난다면 버전 부족이 아니라 런타임 파일을
찾는 경로 문제로 보는 편이 맞습니다.

```text
module 'vim.uri' not found
E484: Can't open file .../syntax/syntax.vim
```

`vim.uri`와 `syntax/syntax.vim`은 플러그인이 아니라 Neovim 기본 런타임 파일입니다.
먼저 다음 명령으로 런타임 파일이 실제로 보이는지 확인하세요.

```bash
nvim --clean --headless \
  '+lua print(vim.env.VIMRUNTIME); print(vim.fn.filereadable(vim.env.VIMRUNTIME .. "/lua/vim/uri.lua")); print(vim.fn.filereadable(vim.env.VIMRUNTIME .. "/syntax/syntax.vim"))' \
  +qa
```

정상이라면 마지막 두 줄이 모두 `1`이어야 합니다. `0`이 나오거나
`$VIMRUNTIME`가 `~/.local/share/nvim`처럼 플러그인 데이터 디렉터리를 가리키면
셸 설정에서 `VIMRUNTIME` export를 제거한 뒤 터미널을 다시 여세요.

소스 빌드한 Neovim을 직접 실행 중이라면 런타임도 함께 설치해야 합니다.

```bash
cd ~/src/neovim
make CMAKE_BUILD_TYPE=Release
sudo make install
```

설치하지 않고 빌드 트리에서 바로 실행해야 한다면, 해당 셸에서만 런타임을
소스 트리의 `runtime` 디렉터리로 지정하세요.

```bash
export VIMRUNTIME="$HOME/src/neovim/runtime"
```

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

- Neovim을 시작하세요.

```bash
nvim
```

## Update and verification

설정 저장소를 유지한 채 최신화하려면 다음 순서로 실행하세요. `lazy-lock.json`도
변경될 수 있으므로, 검증 후 함께 커밋하는 것을 권장합니다.

```bash
cd ~/.config/nvim
git pull --ff-only
nvim
```

Neovim 안에서 `:Lazy update`를 실행한 뒤 재시작하고, 다음을 실행하세요.

```vim
:checkhealth
:TSUpdate
```

Tree-sitter CLI가 없으면 파서 설치가 실패합니다. Java/Spring 환경을 사용하는 경우에는
업데이트 후 Java 파일을 열어 jdtls attach와 포매팅도 한 번 확인하세요.
