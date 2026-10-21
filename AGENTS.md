# AGENTS.md

Nix-darwin + Home Manager flake for one macOS machine (`aarch64-darwin`, user
`yumx`). Full tree and module map: [docs/STRUCTURE.md](docs/STRUCTURE.md).

## Checks

Before finishing, run `nxc check` from the repository root. If `nxc` is not
available, run the commands in [README Checks](README.md#checks).

## Guardrails

- Ask the user to apply; agents never run activation (`nix run .#activate`,
  `nxc apply`, or `darwin-rebuild switch`).
- Use `config.sops.placeholder."<section>/<key>"` for secrets; never open,
  decrypt, or edit `secrets/secrets.yaml`.
- Edit the Nix source; Home Manager's symlinks in `~` are read-only, including
  for `rtk init`.

## Nix Changes

- Search official docs and upstream first; prefer native declarative options.
  Explain any unavoidable custom workaround.
- Stage new files before evaluating; Nix only sees git-tracked files.
- Put modules in the matching domain folder and import them from its
  `default.nix`.
- Keep nixfmt formatting, remove unused arguments, and keep versions in Nix
  files; README and docs stay version-free.

## Sources

- Instructions: repo rules in this file; personal defaults in
  `modules/home/agents/global-agents.md` (copied by `rtk.nix`).
- Source files: `pkgs/nxc/default.nix` for `nxc`, `modules/darwin/mcp.nix` for
  MCP. Codex reads the generated `/etc/codex/config.toml`.
- Maintenance skills:
  `.agents/skills/{bump-opencode,add-skill-source,add-sops-secret}/SKILL.md`.
