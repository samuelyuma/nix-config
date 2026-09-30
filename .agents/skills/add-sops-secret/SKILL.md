---
name: add-sops-secret
description: Add a new sops-nix secret and wire it into a module. Use when a module needs a token, key, or other secret.
---

# Add a sops secret

1. Ask the user to add the value with `sops secrets/secrets.yaml`. Never open or print the decrypted file.
2. Declare `sops.secrets."<section>/<key>" = { };` in its owning module.
3. Consume it through `config.sops.placeholder."<section>/<key>"` in a `sops.templates.<name>.content` with `mode = "0400"`.
4. Stage changes and run `nix flake check`.
5. Tell the user to activate. Do not run activation yourself.
