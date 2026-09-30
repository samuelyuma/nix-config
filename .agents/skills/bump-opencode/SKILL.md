---
name: bump-opencode
description: Bump the pinned OpenCode CLI version and hash in pkgs/opencode. Use when asked to update, upgrade, or bump OpenCode.
---

# Bump OpenCode

1. Get the target version. Ask the user if it was not given.
2. In `pkgs/opencode/default.nix`, set `version = "<new>"` and `hash = lib.fakeHash;`.
3. Stage the package file, then run `nix build .#opencode`. The hash mismatch prints `got: sha256-...`; set that value as `hash`.
4. Run `nix build .#opencode` and `./result/bin/opencode --version`; confirm the new version.
5. Run `nix flake check`.
6. Do not activate. Tell the user to run `nix run .#activate`.

Do not write the version in README or docs.
