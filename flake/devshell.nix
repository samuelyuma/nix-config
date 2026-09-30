{ pkgs, localChecks }:

pkgs.mkShellNoCC {
  inherit (localChecks) shellHook;
  packages = with pkgs; [
    deadnix
    nixfmt-tree
    statix
  ];
}
