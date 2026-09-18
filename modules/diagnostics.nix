{pkgs, ...}: {
  vim = {
    extraPackages = with pkgs; [
      ruff
      shellcheck
      clang-tools
      # sqlfluff
      ktlint
      lua52Packages.luacheck
      markdownlint-cli2
      statix
      yamllint
      hadolint
    ];

    diagnostics.nvim-lint = {
      enable = true;

      linters_by_ft = {
        python = ["ruff"];
        bash = ["shellcheck"];
        sh = ["shellcheck"];
        c = ["clangtidy"];
        cpp = ["clangtidy"];
        # sql = ["sqlfluff"];
        kotlin = ["ktlint"];
        lua = ["luacheck"];
        markdown = ["markdownlint"];
        nix = ["statix"];
        yaml = ["yamllint"];
        dockerfile = ["hadolint"];
      };
    };
  };
}
