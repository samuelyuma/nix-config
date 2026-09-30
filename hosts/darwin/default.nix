{ host, ... }:

{
  imports = [ ../../modules/darwin ];

  nix.enable = false;
  nixpkgs.hostPlatform = host.system;
  system.primaryUser = host.username;
  system.stateVersion = 6;

  users.users.${host.username}.home = host.homeDirectory;
}
