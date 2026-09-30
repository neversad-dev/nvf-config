{pkgs, ...}: {
  vim = {
    extraPackages = with pkgs; [
      tuxedo
    ];

    extraPlugins = {
      tuxedo-nvim = {
        package = pkgs.vimUtils.buildVimPlugin {
          pname = "tuxedo-nvim";
          version = "unstable";
          src = pkgs.fetchFromGitHub {
            owner = "IogaMaster";
            repo = "tuxedo.nvim";
            rev = "65650b0ae3b1c3755a43306b07ada13bd78d47ac";
            hash = "sha256-e8Vk2QvMNDDpYCiTWwm5IgDlDhVKj2g+kNHpLbkYGx4=";
          };
        };
        setup = ''
          require('tuxedo').setup({
            create_todo_file = true,
            width_ratio = 0.95,
            height_ratio = 0.80,
          })
        '';
      };
    };
  };
}
