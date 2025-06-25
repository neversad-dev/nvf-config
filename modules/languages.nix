{pkgs, ...}: {
  vim = {
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      ts.enable = true;
      java.enable = true;
      kotlin.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix = {
        enable = true;
        lsp.server = "nixd";
        lsp.package = pkgs.nixd;
      };
      python.enable = true;
      yaml.enable = true;
    };
    comments = {
      comment-nvim.enable = true;
    };
  };
}
