{pkgs, ...}: {
  vim = {
    visuals.fidget-nvim.enable = true; # Shows LSP progress notifications in the corner
    languages = {
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      bash.enable = true;
      clang.enable = true;
      css.enable = true;
      html.enable = true;
      json.enable = true;
      typescript.enable = true;
      sql.enable = true;
      java.enable = true;
      kotlin.enable = true;
      lua.enable = true;
      markdown.enable = true;
      nix = {
        enable = true;
        lsp.servers = ["nixd"];
      };
      python.enable = true;
      yaml.enable = true;
      toml.enable = true;
      xml.enable = true;
      # docker.enable = true;
      env.enable = true;
      just.enable = true;
    };
    comments = {
      comment-nvim.enable = true;
    };
    lsp = {
      enable = true;

      formatOnSave = true;
      lspkind.enable = true;
      lightbulb.enable = true;
      lspsaga.enable = false;
      trouble.enable = true;
      lspSignature.enable = false;
      nvim-docs-view.enable = true;
    };

    extraPackages = with pkgs; [
      alejandra
      prettier
      shfmt
      ruff
    ];

    formatter.conform-nvim = {
      enable = true;

      setupOpts = {
        formatters_by_ft = {
          nix = ["alejandra"];
          markdown = ["prettier"];
          sh = ["shfmt"];
          bash = ["shfmt"];
          python = ["ruff_format"];
        };
      };
    };

    ui.smartcolumn = {
      enable = true;
      setupOpts = {
        disabled_filetypes = [
          "help"
          "text"
        ];
        custom_colorcolumn = {
          # this is a freeform module, it's `buftype = int;` for configuring column position
          nix = "110";
          java = "130";
          kotlin = "130";
          markdown = "80";
        };
      };
    };
  };
}
