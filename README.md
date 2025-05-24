# Welcome to My NixOS Dotfiles

This repository contains my personal NixOS configuration files, designed for a fully reproducible system using Nix flakes.

### About My Configuration

- **Reproducibility with Flakes**: I use Nix flakes to ensure that my setup is easily reproducible across machines, allowing for version-controlled and consistent configurations.
- **Unified NixOS & Home-Manager Configuration**: Instead of separating my NixOS and Home-Manager configurations, I merge them by application. This approach helps maintain a clear and centralized configuration structure, improving modularity and flexibility.

## Folder Structure

My configuration is organized as follows:

```bash
Nixos/
├── flake.nix   # Main configuration entry point
├── flake.lock  # Lock file for flake versions
├── modules/    # Basic system configurations and essential package imports
├── settings/   # One-off settings, usually grouped by type (e.g., themes, services)
├── software/   # Modularized configurations for applications, separated by app or function
└── unused/     # Archived configurations for apps/settings not currently in use
```

## Folder Breakdown

**flake.nix & flake.lock**: Core files for flake-based reproducibility. **flake.nix** defines the system configuration and dependencies, while **flake.lock** keeps track of pinned versions.

**modules/**: Contains base configurations and system imports. Here, you’ll find general settings and essential packages that don’t fit any specific category and require minimal configuration.

**settings/**: Houses settings for applications that generally fit within a single category, such as system security, services, themes, aliases, or any app that doesn’t need extensive / modularized configuration.

**software/**: Reserved for applications or tools that benefit from being broken down into individual files for easier categorization and modular management.

**unused/**: A storage area for currently unused configurations. I keep these files around as a reference or for potential future needs.

## Modular Configuration Philosophy

Some settings are grouped in a single file to prevent dependencies between applications. This way, if I decide to remove an app, I won’t need to search through other files to check for potential dependencies.
