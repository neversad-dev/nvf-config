{pkgs, ...}: {
  vim = {
    startPlugins = with pkgs.vimPlugins; [
      telescope-ui-select-nvim
    ];

    telescope = {
      enable = true;
      setupOpts = {
        extensions = {
          "ui-select" = {
            # This is your opts table
          };
        };
      };
    };

    # Load the ui-select extension
    luaConfigRC.telescope-ui-select = ''
      require("telescope").load_extension("ui-select")
    '';
  };
}
