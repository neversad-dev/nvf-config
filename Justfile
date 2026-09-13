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

# Format Nix code
fmt:
    # format the nix files in this repo
    nix fmt . --accept-flake-config

# Update flake inputs
up:
    nix flake update
