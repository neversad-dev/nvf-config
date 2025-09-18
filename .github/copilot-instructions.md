# Copilot Instructions for nvf-config

## Repository Overview

This repository provides a **custom Neovim configuration** built using [nvf (neovim flake)](https://github.com/notashelf/nvf). It creates a fully-featured Neovim setup with LSP integration, modern plugins, and Catppuccin theming that can be used as a Nix flake input or standalone package.

### Key Facts
- **Type**: Neovim configuration library using nvf framework
- **Architecture**: Modular configuration with separate concerns (languages, plugins, theme, etc.)
- **Size**: ~21 Nix files in modular structure
- **Languages**: Nix (primary configuration language)
- **Platforms**: Cross-platform (aarch64-darwin, x86_64-linux, aarch64-linux)
- **Output**: Configured Neovim package with plugins and settings
- **License**: MIT

## Build System & Commands

### Prerequisites
- **Nix version**: 2.28.3+ with experimental features (`nix-command flakes`)
- **No external dependencies**: Everything managed through Nix
- **nvf framework**: Uses notashelf/nvf as the underlying Neovim builder

### Essential Commands

```bash
# Validation
nix flake check --accept-flake-config      # Check flake validity
nix fmt . --accept-flake-config -- --check # Check code formatting
nix fmt . --accept-flake-config            # Format code (ALWAYS run before commits)

# Testing/Running
nix run .                                  # Run Neovim with this configuration
nix run github:neversad-dev/nvf-config    # Run from GitHub directly

# Building
nix build .                                # Build the Neovim package
nix build .#nvim                          # Build explicit nvim package
```

### Build Process
1. **nvf integration**: Uses nvf.lib.neovimConfiguration to build Neovim
2. **Module scanning**: Automatically imports all .nix files from modules/ directory
3. **Cross-platform**: Builds packages for all supported systems
4. **Library functions**: Exposes helper functions for integration into other flakes

## Project Architecture

### Directory Structure
```
├── flake.nix                 # Main flake entry point
├── flake.lock               # Dependency lock file (auto-managed)
├── lib/                     # Helper library functions
│   └── default.nix         # Path scanning utilities
├── modules/                 # Neovim configuration modules
│   ├── default.nix         # Module aggregator (auto-imports all)
│   ├── core.nix            # Core Vim settings (leader key, aliases, etc.)
│   ├── languages.nix       # Language support (LSP, formatters, etc.)
│   ├── lsp.nix             # LSP configuration and settings
│   ├── theme.nix           # Catppuccin theme configuration
│   ├── autocomplete.nix    # Auto-completion settings
│   ├── debugger.nix        # DAP debugging configuration
│   ├── diagnostics.nix     # Diagnostic display settings
│   ├── ui.nix              # UI enhancements
│   └── plugins/            # Plugin-specific configurations
│       ├── default.nix     # Plugin aggregator
│       ├── telescope.nix   # Fuzzy finder configuration
│       ├── filetree.nix    # File explorer settings
│       ├── terminal.nix    # Terminal integration
│       ├── git.nix         # Git integration plugins
│       └── [other plugins] # Additional plugin configs
├── README.md               # Documentation
└── LICENSE                 # MIT license
```

### Configuration Organization

**Modular Design**: Each aspect of Neovim is configured in separate files:
- **Languages**: LSP servers, formatters, treesitter for specific languages
- **Plugins**: Individual plugin configurations with their specific settings
- **Core**: Basic Vim behavior and key mappings
- **Theme**: Visual appearance and color scheme

**Auto-importing**: The `lib/default.nix` provides a `scanPaths` function that automatically imports all .nix files in a directory, eliminating manual import management.

### Key Configuration Details

**Supported Languages**:
- Nix (with nixd LSP server)
- TypeScript/JavaScript
- Python, Java, Kotlin
- Bash, Lua, CSS, HTML
- Markdown, YAML

**Major Features**:
- LSP integration with format-on-save
- Telescope fuzzy finder with UI-select extension
- File tree with neo-tree (Ctrl+N shortcut)
- Git integration with gitsigns
- Terminal integration with toggleterm and lazygit
- DAP debugging support
- Catppuccin Mocha theme with transparency

## API & Integration

### Package Usage

**Direct package access** - Simple and straightforward:
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

**Standalone packages**: Available as `packages.default` and `packages.nvim` for each system.

## Development Guidelines

### Making Configuration Changes

1. **Choose appropriate module**: Edit files in `modules/` based on functionality
   - Languages: `languages.nix`
   - Plugins: `plugins/<plugin-name>.nix`
   - Core behavior: `core.nix`
   - Appearance: `theme.nix` or `ui.nix`

2. **Follow nvf patterns**: Use nvf configuration options (see [nvf options](https://notashelf.github.io/nvf/options.html))

3. **Test changes**: `nix run .` to test Neovim with your changes

4. **Format code**: `nix fmt . --accept-flake-config` (ALWAYS before committing)

5. **Validate**: `nix flake check --accept-flake-config`

### Adding New Languages

Edit `modules/languages.nix`:
```nix
vim.languages = {
  # Enable new language
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

**LSP settings** (`modules/lsp.nix`):
```nix
vim.lsp = {
  formatOnSave = true;  # Auto-format on save
  trouble.enable = true; # Error/warning display
};
```

## Validation & Quality

```bash
# Complete validation sequence
nix flake check --accept-flake-config
nix fmt . --accept-flake-config -- --check
nix run . # Manual testing
```

### Code Quality Requirements
- **ALWAYS format code** before committing: `nix fmt . --accept-flake-config`
- **Test functionality** by running the configuration: `nix run .`
- **Validate flake structure**: `nix flake check --accept-flake-config`

### Integration Testing
Since this is used as a library by other flakes (like nix-config), test integration:
## Dependencies & Framework

### Core Dependencies
- **nixpkgs**: Standard Nix packages
- **nvf**: The neovim flake framework (notashelf/nvf)
- **nvf provides**: All Neovim plugins, LSP servers, and configuration options

### Framework Integration
This configuration is built **on top of nvf**, not from scratch:
- Uses `nvf.lib.neovimConfiguration` internally to build packages
- Follows nvf's option structure and patterns
- All available options documented at: https://notashelf.github.io/nvf/options.html
- **Simplified API**: No complex functions, just use the packages directly

### System Support
- **aarch64-darwin**: Apple Silicon Macs
- **x86_64-linux**: Intel/AMD Linux
- **aarch64-linux**: ARM64 Linux

