{ host, ... }:

{
  imports = [
    ./agent-skills
    ./editor
    ./opencode
    ./packages
    ./security
    ./shell
    ./terminal
    ./vcs/git.nix
  ];

  home = {
    inherit (host) homeDirectory username;
    stateVersion = "26.05";
  };
}
