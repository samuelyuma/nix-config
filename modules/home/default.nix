{ host, lib, ... }:

{
  imports = [
    ./agents
    ./editor
    ./nix
    ./packages
    ./security
    ./shell
    ./vcs/git.nix
  ]
  ++ lib.optionals (host.profile == "darwin") [ ./terminal ];

  home = {
    inherit (host) homeDirectory username;
    stateVersion = "26.05";
  };
}
