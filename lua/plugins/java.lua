-- Java 세트(nvim-jdtls + jdtls/java-debug/java-test)는 config/lazy.lua 에서
-- `lazyvim.plugins.extras.lang.java` 를 import 하여 로드됨 (import 순서 규칙 때문).
-- 이 파일은 그 위에 얹는 커스터마이즈(Spring Boot, Lombok jar 교체)만 담당한다.
return {
  -- Spring Boot 지원: application.yml/properties 자동완성, @어노테이션 힌트 등
  -- (spring-boot-language-server 번들을 jdtls에 확장으로 붙임)
  {
    "JavaHello/spring-boot.nvim",
    ft = { "java", "yaml", "jproperties" },
    dependencies = { "mfussenegger/nvim-jdtls" },
    opts = {},
  },

  -- spring-boot.nvim이 참조하는 Spring Boot LS 본체 + 확장 번들 제공 패키지
  {
    "mason-org/mason.nvim",
    opts = { ensure_installed = { "vscode-spring-boot-tools" } },
  },

  -- Java 버퍼에서 inlay hint 비활성화.
  -- Neovim 0.11 + jdtls 조합에서 jdtls가 보내는 hint 컬럼이 버퍼 범위를 벗어나면
  -- "Invalid 'col': out of range" 로 데코레이션 provider가 크래시하는 문제 회피.
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.exclude = opts.inlay_hints.exclude or {}
      table.insert(opts.inlay_hints.exclude, "java")
    end,
  },

  -- jdtls 커스터마이즈: ① Lombok 최신 jar로 교체 ② Spring Boot 확장 번들 주입
  {
    "mfussenegger/nvim-jdtls",
    opts = function(_, opts)
      -- ① Lombok: mason 번들 lombok 대신 config 리포에 백업해 둔 최신 lombok.jar 사용.
      --    stdpath("config") 기준 상대경로 → 다른 머신에 clone 해도 그대로 동작(이식성).
      local lombok = vim.fn.stdpath("config") .. "/jars/lombok.jar"
      local jvm_arg = "--jvm-arg=-javaagent:" .. lombok
      opts.cmd = opts.cmd or {}
      local replaced = false
      for i, arg in ipairs(opts.cmd) do
        if type(arg) == "string" and arg:match("%-javaagent:.*lombok") then
          opts.cmd[i] = jvm_arg
          replaced = true
          break
        end
      end
      if not replaced then
        table.insert(opts.cmd, jvm_arg)
      end

      -- ② Spring Boot 확장 번들을 jdtls init_options.bundles 에 추가.
      --    opts.jdtls 를 "함수"로 주면 extend_or_override 가 base config 를 넘겨주므로
      --    기존 번들(java-debug/java-test)을 보존한 채 append 할 수 있다.
      opts.jdtls = function(config)
        config.init_options = config.init_options or {}
        config.init_options.bundles = config.init_options.bundles or {}
        local ok, spring_boot = pcall(require, "spring_boot")
        if ok then
          vim.list_extend(config.init_options.bundles, spring_boot.java_extensions())
        end
      end
    end,
  },
}
