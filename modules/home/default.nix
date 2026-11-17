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
  ++ lib.optionals (host.profile == "darwin") [
    ./editor/zed.nix
    ./terminal
  ];

  home = {
    inherit (host) homeDirectory username;
    stateVersion = "26.05";
  };
}
