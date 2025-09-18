{
  description = "Custom nvf (neovim) configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    self,
    nixpkgs,
    nvf,
    ...
  }: let
    # Define supported systems
    darwinSystems = {
      aarch64 = "aarch64-darwin";
    };
    linuxSystems = {
      x86_64 = "x86_64-linux";
      aarch64 = "aarch64-linux";
    };

    allSystems = builtins.attrValues darwinSystems ++ builtins.attrValues linuxSystems;
    forAllSystems = func: (nixpkgs.lib.genAttrs allSystems func);

    # Helper library functions
    mylib = import ./lib {inherit (nixpkgs) lib;};
  in {
    # Expose the neovim configuration as a function
    lib.neovimConfiguration = {
      system,
      extraSpecialArgs ? {},
    }:
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.${system};
        modules = [./modules];
        extraSpecialArgs = {inherit mylib;} // extraSpecialArgs;
      }).neovim;

    # Helper function to create Neovim for any system
    lib.mkNeovim = system: extraSpecialArgs:
      self.lib.neovimConfiguration {
        inherit system extraSpecialArgs;
      };

    # Provide standalone neovim packages for each system
    packages = forAllSystems (system: {
      default = self.lib.neovimConfiguration {inherit system;};
      nvim = self.lib.neovimConfiguration {inherit system;};
    });

    # Format the nix code in this flake
    formatter = forAllSystems (
      system: nixpkgs.legacyPackages.${system}.alejandra
    );
  };
}
