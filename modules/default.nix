{mylib, ...}: {
  # imports = mylib.scanPaths ./.;
  imports = [
    ./core.nix
    ./theme.nix
    ./autocomplete.nix
    ./ui.nix
    ./languages.nix
    # ./diagnostics.nix
  ];
}
