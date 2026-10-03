{ host, lib, ... }:

{
  imports = [ ../../modules/darwin ];

  nix.enable = false;
  nixpkgs.hostPlatform = host.system;
  nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [ "antigravity-acp" ];
  system.primaryUser = host.username;
  system.stateVersion = 6;

  users.users.${host.username}.home = host.homeDirectory;
}
