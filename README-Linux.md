# 💤 LazyVim — Linux

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

s4ng custom

> [Windows](README.md) · [macOS](README-macOS.md) · **Linux**

## Pre-requirements

플러그인 매니저(lazy.nvim)는 git 저장소만 관리하고 **시스템 CLI/바이너리는 직접 설치**해야 합니다.
설치 후 `nvim`에서 `:checkhealth`로 누락된 의존성을 확인할 수 있습니다.

### 필수

| 도구 | 용도 |
|---|---|
| **Neovim ≥ 0.12.0** | nvim-treesitter `main` 브랜치의 최소 요구사항 (아래 참고) |
| **git** | 플러그인 clone (lazy.nvim) |
| **C 컴파일러** (clang/gcc, 또는 zig) | Treesitter 파서 컴파일 |
| **[tree-sitter CLI](https://github.com/tree-sitter/tree-sitter/blob/master/cli/README.md) ≥ 0.26.1** | Treesitter 파서 설치/업데이트 |
| **[ripgrep](https://github.com/BurntSushi/ripgrep) (`rg`)** | 텍스트 검색 (snacks picker) |
| **curl · tar** | Treesitter 파서 소스 다운로드/해제 |
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

### 기능별 (해당 기능을 쓸 때만)

| 기능 | 필요한 것 |
|---|---|
| **클립보드 연동** | X11: `xclip`/`xsel`, Wayland: `wl-clipboard` |

> 한/영 입력기 표시([ime-status](https://github.com/s4ng/ime-status.nvim))는
> **추가로 설치할 것이 없습니다.** 예전에는 `fcitx5-remote` 같은 외부 도구를
> `PATH`에서 찾았지만, 지금은 fcitx5·ibus 데몬에 D-Bus로 직접 붙습니다
> (순수 Lua, FFI 없음). 즉 평소 쓰던 한글 입력기가 그냥 떠 있으면 되고,
> 플러그인 때문에 따로 깔 패키지는 없습니다. 입력기가 아예 없어도 에러 없이
> `EN`만 표시됩니다. `:checkhealth ime-status`가 이 머신에서 어느 데몬이
> 어떤 상태인지 알려줍니다.

## 설치 (Debian/Ubuntu)

아래 순서 그대로 실행하면 됩니다. Debian 13 (trixie) / WSL2에서 검증했습니다.

```bash
# 1) apt로 받을 수 있는 것들
sudo apt update
sudo apt install -y git curl tar ripgrep fd-find fzf lazygit \
                    nodejs npm build-essential xclip
```

apt의 `tree-sitter-cli`와 `neovim`은 **일부러 빼두었습니다.** 두 패키지 모두
이 설정이 요구하는 버전보다 낮습니다(Debian 13 기준 `tree-sitter-cli` 0.22.6,
`neovim` 0.10.4). 이어서 다음을 설치하세요.

```bash
# 2) Neovim 0.12.x (공식 stable tarball)
curl -fsSLO https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz
tar -xzf nvim-linux-x86_64.tar.gz
sudo rm -rf /opt/nvim && sudo mv nvim-linux-x86_64 /opt/nvim
sudo ln -sf /opt/nvim/bin/nvim /usr/local/bin/nvim
nvim --version | head -1        # NVIM v0.12.x 인지 확인

# 3) tree-sitter CLI 0.26.1 이상 (apt 버전은 너무 낮음)
sudo npm install -g tree-sitter-cli
tree-sitter --version           # 0.26.1 이상인지 확인
```

```bash
# 선택: Debian 계열은 fd가 fdfind 이름으로 설치됩니다.
# snacks picker는 fdfind도 그대로 인식하므로 필수는 아닙니다.
mkdir -p ~/.local/bin                       # 디렉터리가 없으면 ln이 실패합니다
ln -sf "$(command -v fdfind)" ~/.local/bin/fd
# ~/.local/bin 이 PATH에 없다면 셸 설정에 추가하세요
# echo 'export PATH="$HOME/.local/bin:$PATH"' >> ~/.bashrc
```

```bash
# 선택: Wayland 클립보드 (X11이면 위에서 설치한 xclip으로 충분)
sudo apt install -y wl-clipboard
```

> Debian/Ubuntu 기본 저장소의 `neovim` 패키지는 대부분 너무 오래되었습니다
> (Debian 13 = 0.10.4 < 필수 0.12.0). `nvim --version`으로 실제 버전을
> 먼저 확인하세요.

### C 컴파일러를 zig로 쓰는 경우

`build-essential`(gcc) 대신 zig만 쓰고 싶다면 zig를 설치하세요. zig는 apt에
없으므로 공식 tarball을 씁니다.

```bash
curl -fsSLO https://ziglang.org/download/0.16.0/zig-x86_64-linux-0.16.0.tar.xz
tar -xf zig-x86_64-linux-0.16.0.tar.xz
sudo rm -rf /opt/zig && sudo mv zig-x86_64-linux-0.16.0 /opt/zig
sudo ln -sf /opt/zig/zig /usr/local/bin/zig
zig version
```

`CC="zig cc"`를 그냥 내보내면 **동작하지 않습니다.** tree-sitter CLI가
`CC` 값 전체를 실행 파일 경로로 보기 때문에 `cc` 서브커맨드가 사라지고,
zig를 clang 계열로 감지하면 zig가 파싱하지 못하는 Rust 형식 트리플
(`--target=x86_64-unknown-linux-gnu` → `UnknownOperatingSystem`)을 넘깁니다.
이 저장소는 그래서 `scripts/zig-cc.sh` 래퍼를 함께 둡니다.

`cc`/`gcc`/`clang`이 없고 `zig`만 있으면 `lua/config/options.lua`가 이 래퍼를
`$CC`로 자동 지정하므로, **zig만 설치하면 추가 설정은 필요 없습니다.**

## 런타임 경로 오류

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
