{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    age
    sops
  ];

  home.sessionVariables.SOPS_AGE_KEY_FILE = "${config.home.homeDirectory}/.config/sops/age/keys.txt";

  sops = {
    age.keyFile = config.home.sessionVariables.SOPS_AGE_KEY_FILE;
    defaultSopsFile = ../../../secrets/secrets.yaml;
  };
}
