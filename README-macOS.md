# 💤 LazyVim — macOS

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

s4ng custom

> [Windows](README.md) · **macOS** · [Linux](README-Linux.md)

## Pre-requirements

플러그인 매니저(lazy.nvim)는 git 저장소만 관리하고 **시스템 CLI/바이너리는 직접 설치**해야 합니다.
설치 후 `nvim`에서 `:checkhealth`로 누락된 의존성을 확인할 수 있습니다.

### 필수

| 도구 | 용도 |
|---|---|
| **Neovim ≥ 0.12.0** | nvim-treesitter `main` 브랜치의 최소 요구사항 (아래 참고) |
| **git** | 플러그인 clone (lazy.nvim) |
| **C 컴파일러** (clang) | Treesitter 파서 컴파일 — `xcode-select --install`로 제공 |
| **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) ≥ 0.26.1** | Treesitter 파서 설치/업데이트 |
| **[ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)** | 텍스트 검색 (snacks picker) |
| **curl · tar** | Treesitter 파서 소스 다운로드/해제 (macOS 기본 포함) |
| **[Nerd Font](https://www.nerdfonts.com/)** | 아이콘 표시 (터미널 폰트로 지정) |

> **왜 0.12 이상인가**
> LazyVim이 쓰는 nvim-treesitter는 `main` 브랜치로 넘어갔고, 이 브랜치의
> `health.lua`가 `Nvim-treesitter requires Neovim 0.12.0 or later.`로 명시적으로
> 막습니다. 0.11.x에서는 `:checkhealth nvim-treesitter`가 에러를 냅니다.
> Neovim 0.12는 `vim.lsp.config()` / `vim.lsp.enable()` 같은 **LSP 클라이언트**를
> 내장하지만 **서버 정의(`lsp/*.lua`)는 내장하지 않습니다.** 서버 설정은 여전히
> nvim-lspconfig(LazyVim 본체가 가져옴)가 제공하므로 제거하면 안 됩니다.

### 권장

| 도구 | 용도 |
|---|---|
| **[fd](https://github.com/sharkdp/fd)** | 빠른 파일 검색 |
| **[fzf](https://github.com/junegunn/fzf)** | LazyVim `:checkhealth lazyvim`이 확인하는 항목 |
| **[lazygit](https://github.com/jesseduffield/lazygit)** | Git UI (`<leader>gg`) |
| **Node.js (npm)** | tree-sitter CLI 설치 · 일부 LSP · mason 도구(markdownlint 등) · markdown-preview |

> 한/영 입력기 표시([ime-status](https://github.com/s4ng/ime-status.nvim))는
> **추가로 설치할 것이 없습니다.** Carbon TIS API를 LuaJIT FFI로 직접 읽으므로
> 외부 프로그램(`macism`, `im-select` 등)을 `PATH`에서 찾지 않습니다.
> `:checkhealth ime-status`로 확인하세요.

### 설치 예시 (Homebrew)

```bash
# C 컴파일러 (이미 설치되어 있으면 건너뜁니다)
xcode-select --install

# 필수 + 권장
brew install neovim git ripgrep fd fzf lazygit node tree-sitter-cli
brew install --cask font-hack-nerd-font   # Nerd Font (설치 후 터미널 폰트로 지정)
```

설치 후 버전을 먼저 확인하세요. 오래된 버전이 잡히면
`:checkhealth nvim-treesitter`가 에러를 냅니다.

```bash
nvim --version | head -1    # v0.12.0 이상
tree-sitter --version       # 0.26.1 이상
```

### C 컴파일러를 zig로 쓰는 경우

macOS는 `xcode-select --install`로 clang이 들어오므로 보통 zig는 필요 없습니다.
Command Line Tools 없이 zig만 쓰고 싶다면 `brew install zig`로 설치하세요.

`CC="zig cc"`를 그냥 내보내면 **동작하지 않습니다.** tree-sitter CLI가 `CC` 값
전체를 실행 파일 경로로 보기 때문에 `cc` 서브커맨드가 사라지고, zig를 clang
계열로 감지하면 zig가 파싱하지 못하는 Rust 형식 트리플을 넘깁니다. 이 저장소는
그래서 `scripts/zig-cc.sh` 래퍼를 함께 둡니다.

`cc`/`gcc`/`clang`이 없고 `zig`만 있으면 `lua/config/options.lua`가 이 래퍼를
`$CC`로 자동 지정하므로, **zig만 설치하면 추가 설정은 필요 없습니다.**

## Usage

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

Tree-sitter CLI가 없으면 파서 설치가 실패합니다.
