{
  inputs,
  pkgs,
  host,
}:

inputs.git-hooks.lib.${host.system}.run {
  src = ../.;
  hooks = {
    nixfmt = {
      enable = true;
      entry = "${pkgs.nixfmt-tree}/bin/treefmt --ci";
      files = "\\.nix$";
      pass_filenames = false;
    };
    statix = {
      enable = true;
      entry = "${pkgs.statix}/bin/statix check .";
      files = "\\.nix$";
      pass_filenames = false;
    };
    deadnix = {
      enable = true;
      entry = "${pkgs.deadnix}/bin/deadnix .";
      files = "\\.nix$";
      pass_filenames = false;
    };
    flake-check = {
      enable = true;
      name = "nix flake check";
      entry = "${pkgs.nix}/bin/nix flake check --no-update-lock-file --print-build-logs";
      always_run = true;
      pass_filenames = false;
      stages = [ "pre-push" ];
    };
  };
}
