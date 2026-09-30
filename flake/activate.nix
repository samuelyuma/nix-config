{
  inputs,
  pkgs,
  host,
  self,
}:

pkgs.writeShellScriptBin "activate" ''
  exec /usr/bin/sudo /usr/bin/env \
    HOME=/var/root \
    PATH=/nix/var/nix/profiles/default/bin:/run/current-system/sw/bin:$PATH \
    ${inputs.nix-darwin.packages.${host.system}.darwin-rebuild}/bin/darwin-rebuild \
    switch --flake "${self.outPath}#darwin"
''
