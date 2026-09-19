# Copilot Instructions for nvf-config

## Repository Overview

This repository provides a **custom Neovim configuration** built using [nvf (neovim flake)](https://github.com/notashelf/nvf). It creates a fully-featured Neovim setup with LSP integration, modern plugins, and Catppuccin theming that can be used as a Nix flake input or standalone package.

### Key Facts

- **Type**: Neovim configuration library using nvf framework
- **Architecture**: Modular configuration with separate concerns (languages, plugins, theme, etc.)
- **Size**: ~20 Nix files in modular structure
- **Languages**: Nix (primary configuration language)
- **Platforms**: Cross-platform (`aarch64-darwin`, `x86_64-linux`, `aarch64-linux`)
- **Output**: Configured Neovim package with plugins and settings
- **License**: MIT

## Build System & Commands

### Prerequisites

- **Nix version**: 2.28.3+ with experimental features (`nix-command flakes`)
- **No external dependencies**: Everything managed through Nix
- **nvf framework**: Uses `notashelf/nvf` as the underlying Neovim builder
- **Just / Direnv**: Recommended for local development workflow (`direnv allow`)

### Essential Commands

#### Using Just (Recommended)

```bash
just build   # Build the default Neovim package
just run     # Test-run local Neovim configuration
just check   # Run nix flake check across all systems
just fmt     # Format Nix code (ALWAYS run before commits)
just up      # Update flake inputs
```

#### Using Nix Directly

```bash
# Validation
nix flake check --accept-flake-config      # Check flake validity
nix fmt . --accept-flake-config -- --check # Check code formatting
nix fmt . --accept-flake-config            # Format code (ALWAYS run before commits)

# Testing/Running
nix run .                                  # Run Neovim with this configuration
nix run github:neversad-dev/nvf-config    # Run from GitHub directly

# Building & Dev Shell
nix build .#default                        # Build the default Neovim package
nix build .#nvim                           # Build explicit nvim package
nix develop                                # Enter dev shell (with alejandra, nix-melt, nix-tree, just)
```

### Build Process

1. **nvf integration**: Uses `nvf.lib.neovimConfiguration` to build Neovim
2. **Module scanning**: Automatically imports all `.nix` files from `modules/` directory via `scanPaths`
3. **Cross-platform**: Builds packages for `aarch64-darwin`, `x86_64-linux`, and `aarch64-linux`
4. **Library functions**: Exposes helper functions for integration into other flakes

## Project Architecture

### Directory Structure

```
├── flake.nix                 # Main flake entry point (packages, devShells, formatters)
├── flake.lock               # Dependency lock file (auto-managed)
├── Justfile                  # Development task runner recipes
├── .envrc                    # Direnv integration for Nix flake dev shell
├── lib/                     # Helper library functions
│   └── default.nix         # Path scanning utilities (scanPaths)
├── modules/                 # Neovim configuration modules
│   ├── default.nix         # Module aggregator (auto-imports all .nix files)
│   ├── core.nix            # Core Vim settings (leader key, spellcheck, autopairs, etc.)
│   ├── languages.nix       # Language support, LSP (nixd), formatters (conform), extraDiagnostics
│   ├── keymaps.nix         # Key mappings and bind utilities
│   ├── theme.nix           # Catppuccin theme configuration
│   ├── autocomplete.nix    # Auto-completion settings (blink-cmp)
│   ├── debugger.nix        # DAP debugging configuration
│   ├── ui.nix              # UI enhancements (Noice, Smartcolumn, Fidget, Cinnamon, Fastaction)
│   └── plugins/            # Plugin-specific configurations
│       ├── default.nix     # Plugin aggregator
│       ├── telescope.nix   # Fuzzy finder configuration (fzf-native)
│       ├── filetree.nix    # File explorer settings (neo-tree)
│       ├── terminal.nix    # Terminal integration (toggleterm, lazygit)
│       ├── git.nix         # Git integration plugins (gitsigns)
│       └── [other plugins] # Additional plugin configs
├── README.md               # Documentation
└── LICENSE                 # MIT license
```

### Configuration Organization

**Modular Design**: Each aspect of Neovim is configured in separate files:

- **Languages (`languages.nix`)**: LSP servers (`nixd`), treesitter, formatters (`conform-nvim` with `alejandra`, `prettier`, `shfmt`, `ruff_format`), and extra diagnostics (`nvim-lint`).
- **Plugins (`plugins/`)**: Individual plugin configurations with their specific settings.
- **UI (`ui.nix`)**: Noice, Fidget, Cinnamon smooth scrolling, Smartcolumn line highlighting, and Fastaction code actions.
- **Core (`core.nix` & `keymaps.nix`)**: Basic Vim behavior, leader keys (`mapleader = " "`, `localleader = "\\"`), and shortcuts.
- **Theme (`theme.nix`)**: Visual appearance and Catppuccin color scheme.

**Auto-importing**: `lib/default.nix` provides a `scanPaths` function that automatically imports all `.nix` files in `modules/`, eliminating manual import list management.

### Key Configuration Details

**Supported Languages**:

- Nix (with `nixd` LSP server)
- TypeScript / JavaScript
- Python, Java, Kotlin
- Bash, Lua, CSS, HTML
- Markdown, YAML, TOML, XML, env, Just, SQL

**Major Features**:

- LSP integration with format-on-save (`conform-nvim`)
- Extra diagnostics automatically managed via `enableExtraDiagnostics = true`
- Next-generation completion with `blink-cmp`
- Telescope fuzzy finder with native `fzf` extension
- File tree with `neo-tree` (`Ctrl+N` shortcut)
- Git integration with `gitsigns`
- Terminal integration with `toggleterm` and `lazygit` (`<leader>gg`)
- DAP debugging support (`nvim-dap`)
- Catppuccin Mocha theme with transparency

## API & Integration

### Package Usage

**Direct package access**:

```nix
# Use the pre-built Neovim package for your system
nvf-config.packages.${system}.default
```

### Usage Patterns

**As flake input in home-manager**:

```nix
home.packages = [
  nvf-config.packages.${system}.default
];
```

**Standalone packages**: Available as `packages.default` and `packages.nvim` for each supported system (`aarch64-darwin`, `x86_64-linux`, `aarch64-linux`).

## Development Guidelines

### Making Configuration Changes

1. **Choose appropriate module**: Edit files in `modules/` based on functionality
   - Languages, LSP & Formatting: `languages.nix`
   - Plugins: `plugins/<plugin-name>.nix`
   - Keybindings: `keymaps.nix` or `core.nix`
   - Appearance: `theme.nix` or `ui.nix`

2. **Follow nvf patterns**: Use nvf configuration options (see [nvf options](https://notashelf.github.io/nvf/options.html))

3. **Test changes**: Run `just run` or `nix run .` to test Neovim with your changes

4. **Format code**: Run `just fmt` or `nix fmt . --accept-flake-config` (ALWAYS before committing)

5. **Validate**: Run `just check` or `nix flake check --accept-flake-config`

### Adding New Languages

Edit `modules/languages.nix`:

```nix
vim.languages = {
  # Enable new language module
  rust.enable = true;
  go.enable = true;
};
```

### Adding New Plugins

Create `modules/plugins/<plugin-name>.nix`:

```nix
{pkgs, ...}: {
  vim = {
    startPlugins = with pkgs.vimPlugins; [
      plugin-name
    ];

    # Plugin-specific configuration
    pluginName = {
      enable = true;
      # plugin options
    };
  };
}
```

### Common Customizations

**Theme changes** (`modules/theme.nix`):

```nix
vim.theme = {
  name = "catppuccin";
  style = "mocha";      # mocha, macchiato, frappe, latte
  transparent = true;   # transparent background
};
```

**LSP & Formatting settings** (`modules/languages.nix`):

```nix
vim.lsp = {
  formatOnSave = true;  # Auto-format on save
  trouble.enable = true; # Error/warning display
};
```

## Validation & Quality

```bash
# Complete validation sequence
just check
just fmt
just run # Manual testing
```

### Code Quality Requirements

- **ALWAYS format code** before committing: `just fmt` or `nix fmt . --accept-flake-config`
- **Test functionality** by running the configuration: `just run` or `nix run .`
- **Validate flake structure**: `just check` or `nix flake check --accept-flake-config`

## Dependencies & Framework

### Core Dependencies

- **nixpkgs**: Standard Nix packages
- **nvf**: The neovim flake framework (`notashelf/nvf`)
- **nvf provides**: All Neovim plugins, LSP servers, and configuration options

### Framework Integration

This configuration is built **on top of nvf**, not from scratch:

- Uses `nvf.lib.neovimConfiguration` internally to build packages
- Follows nvf's option structure and patterns
- All available options documented at: https://notashelf.github.io/nvf/options.html
- **Simplified API**: Direct package usage via flake inputs

### System Support

- **aarch64-darwin**: Apple Silicon Macs
- **x86_64-linux**: Intel/AMD Linux
- **aarch64-linux**: ARM64 Linux
