# NVF Configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white)](https://neovim.io)
[![Build Check](https://img.shields.io/github/actions/workflow/status/neversad-dev/nvf-config/build-check.yml?branch=main&logo=github-actions&logoColor=white&label=build%20check)](https://github.com/neversad-dev/nvf-config/actions/workflows/build-check.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-blue.svg?logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Catppuccin](https://img.shields.io/badge/Catppuccin-302D41?logo=catppuccin&logoColor=DDB6F2)](https://github.com/catppuccin)

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


## Development

To test changes locally:

```bash
nix run .
```

To format the code:

```bash
nix fmt
``` 
