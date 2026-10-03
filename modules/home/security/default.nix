{
  config,
  lib,
  pkgs,
  ...
}:

{
  home = {
    packages = with pkgs; [
      age
      sops
    ];

    sessionVariables.SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

    # Keep the upstream SOPS script, but run it after the current launch agent is installed.
    activation.sops-nix = lib.hm.dag.entryAfter [ "setupLaunchAgents" ] (lib.mkDefault "");
  };

  sops = {
    age.keyFile = config.home.sessionVariables.SOPS_AGE_KEY_FILE;
    defaultSopsFile = ../../../secrets/secrets.yaml;
  };
}
