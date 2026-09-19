{pkgs, ...}: {
  vim = {
    telescope = {
      enable = true;

      extensions = [
        {
          name = "fzf";
          packages = [pkgs.vimPlugins.telescope-fzf-native-nvim];
          setup = {fzf = {fuzzy = true;};};
        }
      ];

      # setupOpts = {
      #   extensions = {
      #     "ui-select" = {
      #       # ui-select options
      #     };
      #   };
      # };
    };

    # extraPlugins.telescope-ui-select = {
    #   package = pkgs.vimPlugins.telescope-ui-select-nvim;

    #   setup = ''
    #     require("telescope").load_extension("ui-select")
    #   '';
    # };
  };
}
