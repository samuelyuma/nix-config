{
  pkgs,
  ...
}:

{
  imports = [ ../../modules/home ];

  targets.genericLinux.enable = true;

  home.file = {
    ".docker/cli-plugins/docker-compose".source = "${pkgs.docker-compose}/bin/docker-compose";
    ".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/bin/docker-buildx";
  };
}
