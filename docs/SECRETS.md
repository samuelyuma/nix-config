# Secrets

## Secrets (sops-nix)

GitHub tokens in `modules/home/agents/opencode` (MCP) and `modules/home/vcs`
(git push/pull) are injected from `secrets/secrets.yaml`, which stays
encrypted in git. First-time setup:

```console
age-keygen -o ~/.config/sops/age/keys.txt
```

Put the printed `age1...` public key into `.sops.yaml`, then store the secrets:

```console
sops secrets/secrets.yaml
```

#### Generating the Tokens

Create two separate fine-grained PATs at **github.com → Settings →
Developer settings → Personal access tokens → Fine-grained tokens →
Generate new token**. Never reuse one token for both — they have different
scopes and travel to different endpoints:

- `mcp_token` (read-only API use), repository access limited to the repos
  you work in, permissions **Contents: Read**, **Issues: Read**,
  **Metadata: Read**
- `personal_access_token` (push/pull), same repository selection, permissions
  **Contents: Read and write**, **Metadata: Read**

Both expire (90 days recommended). When pushes or MCP calls start failing
with auth errors, regenerate at the same page and continue below. If a
selected repo sits in an org with SAML enforcement, click **Configure SSO
→ Authorize** on the token or org access silently fails.

Replace the placeholders, save, and apply:

```yaml
github:
  mcp_token: github_pat_11...
  personal_access_token: github_pat_11...
```

```console
nix run .#activate
```

Until `github/personal_access_token` exists in `secrets.yaml`, git keeps
using an in-memory cache (this git is built without osxkeychain support);
the sops-rendered `~/.git-credentials` takes over automatically on the
first activation after you add it.

To add another secret later, add it under a new key in
`secrets/secrets.yaml` via `sops secrets/secrets.yaml`, reference it in
nix as `config.sops.placeholder."<section>/<key>"`, and re-run activation.
Rotate any token that ever sat in plaintext config on the provider side.
