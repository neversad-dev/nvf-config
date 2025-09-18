# NVF Configuration

This repository contains a custom Neovim configuration built using [nvf (neovim flake)](https://github.com/notashelf/nvf).

## Features

- Language support for Nix, TypeScript, Python, Java, Kotlin, Lua, Bash, and more
- LSP integration with formatting on save
- File tree (neo-tree) with `Ctrl+N` shortcut
- Git integration with gitsigns
- Telescope for fuzzy finding
- Terminal integration with toggleterm and lazygit
- Auto-completion with nvim-cmp
- Debugging support with nvim-dap
- Beautiful UI with Catppuccin theme

## Usage

### As a Flake Input

Add this to your `flake.nix`:

```nix
{
  inputs = {
    # ... your other inputs
    nvf-config.url = "github:neversad-dev/nvf-config";
  };

  outputs = { self, nixpkgs, nvf-config, ... }: {
    # Use in home-manager
    homeConfigurations.myuser = home-manager.lib.homeManagerConfiguration {
      # ... your config
      modules = [
        {
          home.packages = [
            nvf-config.packages.aarch64-darwin.default
          ];
        }
      ];
    };
  };
}
```

### Standalone

```bash
nix run github:neversad-dev/nvf-config
```

## API Reference

### Packages

The flake provides pre-built Neovim packages for each supported system:

```nix
nvf-config.packages.<system>.default
```

Available systems:
- `aarch64-darwin` (Apple Silicon macOS)
- `x86_64-linux` (Linux x86_64)

### Direct Configuration (Advanced)

For advanced use cases, you can use the underlying nvf configuration directly:

```nix
(nvf-config.lib.neovimConfiguration {
  pkgs = nixpkgs.legacyPackages.<system>;
  modules = [./your-modules];
  extraSpecialArgs = { mylib = import ./lib { inherit (nixpkgs) lib; }; };
})
```

Note: The `nvf-config` modules use a local `scanPaths` utility for automatic module discovery, so if you're creating custom modules, you may want to use explicit imports instead.


## Development

To test changes locally:

```bash
nix run .
```

To format the code:

```bash
nix fmt
``` 