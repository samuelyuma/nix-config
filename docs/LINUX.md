# Linux Host

The `linux` host runs standalone Home Manager on GNU/Linux (including Ubuntu VPS setups and other distributions). It does not use
NixOS or nix-darwin. System services such as Docker, Tailscale, and the T3 Code
service stay under the distribution and the official installers; user tooling,
dotfiles, agent configuration, and skills come from this flake.

| Item | Value |
| --- | --- |
| Host name | `linux` |
| System | `x86_64-linux` |
| User | `yumx` |
| Home | `/home/yumx` |
| Repository | `/home/yumx/nix-config` |
| Activation | `nxc apply` (Home Manager) |
| Remote access | T3 Connect, Tailscale direct, Tailscale SSH |

The current sizing target is 2 vCPU, 4 GB RAM, and 60 GB disk. That is enough
for one coding agent plus one browser session at a time. Use 8 GB RAM first if
the workload grows; disk is the second upgrade.

## Before You Start

Collect these before provisioning:

- An Ubuntu LTS x86_64 VPS with a public IPv4 address.
- The SSH public key for `yumx`.
- A Tailscale account with the VPS and your client devices in the same tailnet.
- The same T3 Connect account used on the Mac.
- A GitHub account that can read `samuelyuma/nix-config`.

The VPS age key does not exist yet. Generate it on the VPS after the first Nix
install, then add its public key to `.sops.yaml` on the Mac. Do not reuse the
Mac age key.

## Provision Ubuntu

1. Create the `yumx` user and install the SSH public key.
2. Disable SSH password authentication after key login works.
3. Install the base packages:

   ```console
   sudo apt update
   sudo apt install -y curl git ca-certificates
   ```

4. Add a 4 GB swap file. This absorbs short build and browser spikes on a 4 GB
   machine:

   ```console
   sudo fallocate -l 4G /swapfile
   sudo chmod 600 /swapfile
   sudo mkswap /swapfile
   sudo swapon /swapfile
   echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
   ```

   If `fallocate` is unsupported on the filesystem, use `sudo dd if=/dev/zero
   of=/swapfile bs=1M count=4096 status=progress` instead.

5. Lower swap pressure:

   ```console
   echo 'vm.swappiness=10' | sudo tee /etc/sysctl.d/99-swap.conf
   sudo sysctl --system
   ```

## Install Nix

Use the Determinate Nix installer. It provides a multi-user installation with
flakes enabled:

```console
curl -fsSL https://install.determinate.systems/nix | sh -s -- install
```

Open a new login shell after the installer finishes, then check:

```console
nix --version
nix flake --help
```

## Clone The Repository

The repository is cloned before Home Manager exists, so use `gh` from nixpkgs
when GitHub authentication is needed:

```console
nix shell nixpkgs#gh -c gh auth login
nix shell nixpkgs#gh -c gh repo clone samuelyuma/nix-config ~/nix-config
```

Alternatively, use `git clone https://github.com/samuelyuma/nix-config.git
~/nix-config` for a public repository.

## Create The VPS Age Key

The key must exist before the first Home Manager activation because sops-nix
renders the MCP and Git credentials during activation.

```console
mkdir -p ~/.config/sops/age
nix shell nixpkgs#age -c age-keygen -o ~/.config/sops/age/keys.txt
nix shell nixpkgs#age -c age-keygen -y ~/.config/sops/age/keys.txt
```

The second command prints the public key. On the Mac:

1. Add the `age1...` public key to the `age` list in `.sops.yaml`.
2. Run `sops updatekeys secrets/secrets.yaml`.
3. Commit and push the updated `.sops.yaml` and `secrets/secrets.yaml`.
4. Pull the changes on the VPS.

Never open, decrypt, or edit `secrets/secrets.yaml` by hand. Never copy the Mac
private age key to the VPS.

## First Activation

From `~/nix-config`, use the pinned Home Manager CLI exposed by the flake:

```console
nix run .#home-manager -- switch --flake .#linux
exec zsh -l
nxc path
```

`nxc` points at `~/nix-config` and uses the `linux` Home Manager configuration for
`apply`, `build`, `check`, and `rollback`.

Verify the user environment:

```console
opencode --version
codex --version
agent-browser --version
rtk --version
```

If `nxc` is not on `PATH`, open a new login shell or source the Home Manager
environment again:

```console
exec zsh -l
```

## Docker

Docker Engine stays on the distribution. The Docker CLI, Compose, Buildx, and
lazydocker come from Nix.

1. Add Docker's official apt repository:

   ```console
   sudo apt update
   sudo apt install -y ca-certificates curl
   sudo install -m 0755 -d /etc/apt/keyrings
   sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
   sudo chmod a+r /etc/apt/keyrings/docker.asc
   printf 'deb [arch=%s signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu %s stable\n' \
     "$(dpkg --print-architecture)" "$(. /etc/os-release && echo "$VERSION_CODENAME")" \
     | sudo tee /etc/apt/sources.list.d/docker.list >/dev/null
   sudo apt update
   sudo apt install -y docker-ce docker-ce-cli containerd.io
   ```

2. Enable the daemon and grant access to the `docker` group:

   ```console
   sudo systemctl enable --now docker
   sudo usermod -aG docker "$USER"
   ```

3. Log out and back in, then check the Nix CLI and plugins:

   ```console
   docker --version
   docker compose version
   docker buildx version
   ```

Home Manager creates `~/.docker/cli-plugins/docker-compose` and
`~/.docker/cli-plugins/docker-buildx`, so the Nix Compose and Buildx binaries
are found by the Nix Docker CLI.

Docker publishes ports past UFW. Bind published ports to `127.0.0.1` or the
Tailscale address instead of `0.0.0.0`:

```yaml
ports:
  - "127.0.0.1:8080:8080"
```

## Tailscale And Firewall

Install Tailscale from its official installer:

```console
curl -fsSL https://tailscale.com/install.sh | sh
sudo tailscale up --ssh
tailscale status
```

`--ssh` enables Tailscale SSH and avoids exposing SSH on the public address.
Keep the VPS provider's web console as the recovery path if the tailnet is
unavailable.

Set the host firewall to deny public inbound traffic and allow the tailnet:

```console
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow in on tailscale0
sudo ufw enable
sudo ufw status verbose
```

If you need key-based SSH before Tailscale is up, temporarily allow port 22,
then remove that rule.

## T3 Code

T3 Code stays on its official installer and updater. Do not add it to Nix.

1. Install the CLI:

   ```console
   curl -fsSL https://t3.codes/install.sh | sh
   exec zsh -l
   t3 --version
   ```

2. Start the service with T3 Connect and direct tailnet access:

   ```console
   t3 up --connect --lan
   ```

   `--connect` links the machine to T3 Connect. `--lan` lets clients on the
   tailnet reach it directly. It still does not answer on public addresses.
   Follow the printed sign-in link on another device.

3. Confirm the service:

   ```console
   t3 service status
   ```

   `t3 up` installs the service when setting up T3 Connect. If it did not, run
   `t3 service install`.

4. Protect the service from memory pressure:

   ```console
   t3 service protect
   ```

   This asks for sudo and offers to protect Tailscale and SSH as well. Accept
   those options so the machine remains reachable when an agent fills memory.

5. Install the browser dependencies used by T3 Code and agent-browser:

   ```console
   sudo t3 browser setup
   agent-browser install --with-deps
   ```

   `agent-browser install --with-deps` downloads Chrome for Testing and asks for
   sudo only when system libraries are missing. Run one browser session at a
   time on 4 GB.

6. Update later with the official updater:

   ```console
   t3 update
   ```

### Provider Setup

Open **Settings → Providers** on the `linux` environment.

| Provider | Setup |
| --- | --- |
| Codex | Connect with ChatGPT, or choose manual setup and run `codex login` on the VPS. |
| OpenCode | Detected from the Nix-installed `opencode`; run `opencode auth login` if needed. |
| Antigravity | Enable it, choose **Install Antigravity**, then sign in with Google. |

Antigravity can sign in from a remote device. If the final `127.0.0.1` page does
not load, copy the full return URL, including the query string, into the return
URL field in T3 Code. Do not replace it with the VPS hostname.

Provider CLIs must be on the service `PATH`. Home Manager writes
`~/.config/systemd/user/t3code.service.d/path.conf` with the Home Manager
profile, `/nix/var/nix/profiles/default/bin`, `~/.local/bin`, and the system
paths. After the first activation, reload and restart:

```console
systemctl --user daemon-reload
t3 service restart
```

Use `~/.t3/service.env` for other service variables. `PATH` is one of the
variables that file cannot override.

## Agent Workflow Parity

The same skill sources, agent instructions, and MCP server definitions are used
on both hosts.

| Item | Location |
| --- | --- |
| OpenCode skills | `~/.config/opencode/skills` |
| Codex skills | `~/.codex/skills` |
| Antigravity skills | `~/.gemini/config/skills` |
| OpenCode instructions | `~/.config/opencode/AGENTS.md` |
| Codex instructions | `~/.codex/AGENTS.md` |
| Antigravity instructions | `~/.gemini/config/AGENTS.md` |
| OpenCode MCP | `~/.config/opencode/opencode.jsonc` |
| Codex MCP | `~/.codex/config.toml` |
| Antigravity MCP | `~/.gemini/config/mcp_config.json` |

The three MCP files are sops templates. They only decrypt after the VPS age key
is added to `.sops.yaml` and `sops updatekeys` has run on the Mac.

`agent-browser` is a CLI plus skill, not an MCP server. Its Chrome download is
separate from T3 Code's browser download.

## Resource Limits

Use these defaults on the 4 GB host:

- Run one agent thread with a browser at a time.
- Keep `t3 service protect` enabled.
- Collect Nix garbage periodically:

  ```console
  sudo nix-collect-garbage --delete-older-than 14d
  nix store optimise
  ```

- Prune Docker build cache and unused images:

  ```console
  docker image prune -af
  docker builder prune -af
  ```

  Avoid `docker system prune --volumes` unless you have checked that no named
  volume holds data you need.

- If a build runs out of memory, limit it:

  ```console
  nix build .#homeConfigurations.linux.activationPackage --max-jobs 1 --cores 2
  ```

  The first activation compiles the custom `rtk` package. Expect it to take a
  while on 2 vCPU.

- Run `t3 doctor` when the T3 database grows.

## Updating

```console
cd ~/nix-config
nxc update
nxc check
nxc apply
t3 update
```

- `nxc update` updates all flake inputs.
- `nxc check` formats, lints, evaluates the flake, and builds the Home Manager
  activation package.
- `nxc apply` runs `nh home switch` for `linux`.
- `t3 update` updates T3 Code and its service; Nix does not own that binary.
- Re-run `agent-browser install` after a major agent-browser update if Chrome
  needs to be refreshed.

## Troubleshooting

| Symptom | Check |
| --- | --- |
| `nxc: repository not found` | Clone at `~/nix-config` or set `NXC_REPO`. |
| sops cannot decrypt | `~/.config/sops/age/keys.txt` exists, the VPS public key is in `.sops.yaml`, and `sops updatekeys` ran on the Mac. |
| T3 cannot find Codex or OpenCode | `systemctl --user daemon-reload`, `t3 service restart`, then `command -v codex opencode` in a login shell. |
| T3 stops after SSH closes | `t3 service status`; enable lingering with `sudo loginctl enable-linger yumx`. |
| Docker permission denied | Log out and back in after `usermod -aG docker`. |
| Ports are not reachable | Bind the published port to loopback or the Tailscale address; Docker bypasses UFW. |
| Antigravity remote sign-in fails | Paste the full `127.0.0.1` return URL into the T3 Code sign-in panel. |
| Browser crashes or the host swaps heavily | Close extra threads, keep one browser session, and run `t3 service protect`. |

## Security Notes

- Deny public inbound traffic. Use Tailscale SSH and T3 Connect for access.
- Treat T3 pairing links, authorization codes, and age keys as passwords.
- Never commit plaintext secrets or copy a private age key between hosts.
- Keep Docker published ports on loopback or the tailnet.
- T3 Connect and direct tailnet access are separate routes. Disable either one
  with `t3 up --no-connect` or `t3 up --no-lan` if it is not needed.
