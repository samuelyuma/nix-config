# nix-config

Declarative Nix configuration for one macOS system.

## Layout

- `flake.nix` and `flake/`: inputs, outputs, and flake helpers.
- `hosts/darwin/` and `modules/darwin/`: host and system configuration.
- `modules/home/`: Home Manager configuration by domain.
- `modules/home/agents/`: OpenCode, personal skills, and RTK integration.
- `pkgs/`: custom OpenCode and RTK packages.
- `.agents/skills/`: skills for maintaining this repository.
- `docs/`: [updates](docs/UPDATING.md) and [secrets](docs/SECRETS.md).

## Usage

Nix with `nix-command` and `flakes` is required. `direnv` is optional. This flake uses the existing Determinate Nix installation (`nix.enable = false`).

```console
nix develop
nix fmt -- --ci
statix check .
deadnix .
nix flake check
nix build .#darwinConfigurations.darwin.system
```

Entering the development shell installs Git hooks. Formatting and lint checks run before commits, and the full flake check runs before pushes.

Apply the configuration yourself with `nix run .#activate`. The command handles elevation internally. Reload the shell afterward with `exec zsh -l`. Roll back a problematic generation with `sudo darwin-rebuild --rollback`.

Before using Rust tools on a fresh installation, run `rustup default stable` once to install and select the default toolchain. The workshop runner uses its `cargo` command.
