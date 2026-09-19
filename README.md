# NVF Configuration

[![Built with Nix](https://img.shields.io/badge/Built_With-Nix-5277C3.svg?logo=nixos&labelColor=73C3D5)](https://nixos.org)
[![Neovim](https://img.shields.io/badge/Neovim-57A143?logo=neovim&logoColor=white)](https://neovim.io)
[![Build Check](https://img.shields.io/github/actions/workflow/status/neversad-dev/nvf-config/build-check.yml?branch=main&logo=github-actions&logoColor=white&label=build%20check)](https://github.com/neversad-dev/nvf-config/actions/workflows/build-check.yml)
[![MIT License](https://img.shields.io/badge/License-MIT-green.svg)](https://choosealicense.com/licenses/mit/)
[![Nix Flakes](https://img.shields.io/badge/Nix-Flakes-blue.svg?logo=nixos&logoColor=white)](https://nixos.wiki/wiki/Flakes)
[![Catppuccin](https://img.shields.io/badge/Catppuccin-302D41?logo=catppuccin&logoColor=DDB6F2)](https://github.com/catppuccin)

This repository contains a custom Neovim configuration built using [nvf (neovim flake)](https://github.com/notashelf/nvf).

## Features

- **Language Support**: Comprehensive configuration for Nix (with `nixd`), TypeScript, Python, Java, Kotlin, Lua, Bash, CSS, HTML, SQL, TOML, XML, Markdown, YAML, env, and Just.
- **LSP & Formatting**: Built-in LSP integration with format-on-save via `conform-nvim` (supporting `alejandra`, `prettier`, `shfmt`, `ruff_format`).
- **Auto-completion**: Next-generation completion engine powered by `blink-cmp`.
- **Fuzzy Finding**: Telescope fuzzy finder with native `fzf` extension.
- **File Explorer**: `neo-tree` file manager with `Ctrl+N` toggle shortcut.
- **Git Integration**: Inline status signs and blame with `gitsigns`.
- **Terminal & TUI**: Embedded terminal via `toggleterm` and `lazygit` integration (`<leader>gg`).
- **UI & Motion**: Modern UI powered by Noice, Fidget (LSP progress), Cinnamon (smooth scrolling), Smartcolumn, Fastaction, and Catppuccin theme.
- **Debugging**: Integrated DAP debugging engine (`nvim-dap`).

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
- `aarch64-linux` (Linux ARM64)

## Development

### Using Just (Recommended)

This repository includes a `Justfile` for standard tasks:

```bash
just build   # Build the Neovim package (.#default)
just run     # Run Neovim with local configuration
just check   # Run nix flake check across all systems
just fmt     # Format Nix code with alejandra
just up      # Update flake inputs
```

### Using Nix Directly

```bash
nix run .              # Run Neovim locally
nix build .#default    # Build Neovim package
nix flake check        # Check flake validity
nix fmt                # Format code
nix develop            # Enter dev shell with helper tools (alejandra, nix-melt, nix-tree, just)
```
