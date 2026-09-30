{pkgs, ...}: {
  vim = {
    extraPackages = with pkgs; [
      tuxedo
    ];

    keymaps = [
      {
        key = "<leader>tt";
        mode = "n";
        silent = true;
        action = "<cmd>Tuxedo<CR>";
      }
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
          local tuxedo = require('tuxedo')
          tuxedo.setup({
            create_todo_file = false,
            width_ratio = 0.95,
            height_ratio = 0.80,
          })

          -- Monkey-patch: set TODO_FILE to project-level todo.txt before opening tuxedo
          local orig = tuxedo.tuxedo
          tuxedo.tuxedo = function()
            local root_dir = vim.fs.root(0, { ".git" }) or vim.fn.getcwd()
            vim.fn.setenv("TODO_FILE", root_dir .. "/todo.txt")
            return orig()
          end
        '';
      };
    };
  };
}
