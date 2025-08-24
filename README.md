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
            (nvf-config.lib.neovimConfiguration { 
              system = "aarch64-darwin"; # or your system
              extraSpecialArgs = { /* optional extra args */ };
            })
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

### Helper Function (mkNeovim)

For convenience, you can also use the `mkNeovim` helper function:

```nix
{
  outputs = { self, nixpkgs, nvf-config, ... }: let
    # Define your custom lib or other special args
    mylib = import ./lib { inherit (nixpkgs) lib; };
  in {
    homeConfigurations.myuser = home-manager.lib.homeManagerConfiguration {
      # ... your config
      modules = [
        {
          home.packages = [
            (nvf-config.lib.mkNeovim "aarch64-darwin" { inherit mylib; })
          ];
        }
      ];
    };
  };
}
```

## API Reference

### `lib.neovimConfiguration`

The main configuration function with full control:

```nix
nvf-config.lib.neovimConfiguration {
  system = "aarch64-darwin";        # Required: target system
  extraSpecialArgs = {              # Optional: additional special args
    mylib = /* your lib */;
    # ... other args
  };
}
```

### `lib.mkNeovim`

Convenience helper function:

```nix
nvf-config.lib.mkNeovim system extraSpecialArgs
```

- `system`: Target system (e.g., "aarch64-darwin", "x86_64-linux")
- `extraSpecialArgs`: Attribute set of additional special arguments


## Development

To test changes locally:

```bash
nix run .
```

To format the code:

```bash
nix fmt
``` 