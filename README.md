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

## Development

To test changes locally:

```bash
nix run .
```

To format the code:

```bash
nix fmt
``` 