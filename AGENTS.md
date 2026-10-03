# AGENTS.md

Nix-darwin + Home Manager flake for one macOS machine (aarch64-darwin, user `yumx`). Agents used: OpenCode and Codex.

## Layout

- `flake.nix`: inputs and output wiring; helpers live in `flake/`.
- `hosts/darwin/`: nix-darwin host entry.
- `modules/darwin/`: system config; `modules/home/<domain>/`: Home Manager config.
- `modules/home/agents/`: OpenCode, skills, and RTK.
- `pkgs/`: custom derivations exposed as flake packages.
- `secrets/`: sops encrypted. Never read or print.

## Checks

Run before finishing a change:

```console
nix fmt -- --ci
statix check .
deadnix .
nix flake check
nix build .#darwinConfigurations.darwin.system
```

## Rules

- Before implementing a feature, search official documentation and upstream references for supported approaches. Prefer native, declarative Nix options when available. Use custom scripts or more complex workarounds only after verifying that supported approaches cannot meet the requirements, and explain why.
- Nix only sees git-tracked files. Stage newly created files before evaluating.
- Never run `nix run .#activate` or `darwin-rebuild switch`; ask the user to apply.
- Never open, decrypt, or edit `secrets/secrets.yaml`. Reference secrets through `config.sops.placeholder."<section>/<key>"`.
- MCP configuration for Codex, OpenCode, and Antigravity is rendered by sops-nix from `modules/darwin/mcp.nix`. Codex uses `/etc/codex/config.toml`; edit the module, not the rendered files.
- Home Manager places read-only store symlinks in `~`. Change the Nix source rather than patching those files in place, including with `rtk init`.
- Repo instructions live here. Personal global defaults live in `modules/home/agents/global-agents.md`. `modules/home/agents/rtk.nix` generates `~/.config/opencode/AGENTS.md` from that file, and `~/.codex/AGENTS.md` from that file followed by the RTK instructions. Edit the sources, not the generated files.
- Add modules to the matching domain folder and import them from that folder's `default.nix`.
- Do not hardcode versions in README or docs. Keep nixfmt formatting and remove unused arguments.

## Repo Skills

- `.agents/skills/bump-opencode`: update the pinned OpenCode version and hash.
- `.agents/skills/add-skill-source`: add an external skill repo.
- `.agents/skills/add-sops-secret`: add a new secret.
