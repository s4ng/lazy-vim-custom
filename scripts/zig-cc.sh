#!/bin/sh
# zig cc wrapper for tree-sitter parser builds on machines without gcc/clang.
#
# nvim-treesitter(main)는 tree-sitter CLI(Rust)로 파서를 빌드하는데, 내부
# cc 크레이트가 zig를 clang 계열로 감지하면 Rust 형식 트리플
# (--target=x86_64-unknown-linux-gnu)을 넘긴다. zig는 이 트리플을 파싱하지
# 못하고 `UnknownOperatingSystem`으로 실패한다. 또한 `CC="zig cc"`처럼 공백을
# 넣으면 CLI가 문자열 전체를 실행 파일 경로로 보기 때문에 `cc` 서브커맨드가
# 사라진다. 이 래퍼는 --target 인자를 걷어내고 zig의 기본(native) 타깃으로
# 빌드하게 한다. Windows 쪽 사정은 scripts/zig-cc.ps1 참고.
filtered=""
skip=0
for a in "$@"; do
    case "$a" in
        --target=*) continue ;;
        -target) skip=1; continue ;;
        *) if [ "$skip" = 1 ]; then skip=0; continue; fi ;;
    esac
    filtered="$filtered $a"
done
# shellcheck disable=SC2086
exec zig cc $filtered
