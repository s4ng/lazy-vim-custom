# zig cc wrapper for tree-sitter parser builds on Windows without MSVC.
#
# nvim-treesitter(main)는 tree-sitter CLI(Rust)로 파서를 빌드하는데, 내부
# cc 크레이트가 Windows에서 cl.exe(MSVC)를 기본으로 찾는다. CC 환경변수로
# zig를 지정해도 두 가지가 깨진다:
#   1. `CC=zig cc`처럼 공백이 있으면 `cc` 서브커맨드가 잘려 `zig -O2 ...`로 실행됨
#   2. clang 계열로 감지되면 zig가 이해 못 하는 msvc 트리플
#      (--target=x86_64-pc-windows-msvc)을 넘김
# 이 래퍼는 --target 인자를 걷어내고 zig 형식의 GNU 트리플로 고정한다.
$filtered = @()
foreach ($a in $args) {
  if ($a -like '--target=*') { continue }
  $filtered += $a
}
& zig cc -target x86_64-windows-gnu @filtered
exit $LASTEXITCODE
