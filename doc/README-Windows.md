# 💤 LazyVim 

A starter template for [LazyVim](https://github.com/LazyVim/LazyVim).
Refer to the [documentation](https://lazyvim.github.io/installation) to get started.

s4ng custom

## Usage

Widonws | [Mac or Linux](https://github.com/s4ng/lazy-vim-custom)

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

- .git 디렉토리를 제거하세요.

```
Remove-Item $env:LOCALAPPDATA\nvim\.git -Recurse -Force

```

- Neovim을 시작하세요.

```
nvim
```
