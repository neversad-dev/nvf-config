# NVF Configuration Justfile

# List all the just commands
default:
    @just --list

# Build the Neovim package
build:
    nix build .#default

# Run Neovim with this configuration
run:
    nix run .

# Check the flake
check:
    nix flake check --all-systems

# Format code across project filetypes (Nix, Markdown, YAML)
fmt:
    # Format Nix files with alejandra
    nix fmt . --accept-flake-config
    # Format Markdown and YAML files with prettier
    prettier --write --no-error-on-unmatched-pattern "**/*.md" "**/*.yml" "**/*.yaml"

# Update flake inputs
up:
    nix flake update
