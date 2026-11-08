{
  config,
  host,
  pkgs,
  ...
}:

{
  imports = [ ../../modules/home ];

  targets.genericLinux.enable = true;

  home.file = {
    ".docker/cli-plugins/docker-compose".source = "${pkgs.docker-compose}/bin/docker-compose";
    ".docker/cli-plugins/docker-buildx".source = "${pkgs.docker-buildx}/bin/docker-buildx";

    # T3 Code runs as a systemd user service. Give it the Home Manager profile
    # and the usual system paths so provider CLIs are discoverable.
    ".config/systemd/user/t3code.service.d/path.conf".text = ''
      [Service]
      Environment=PATH=${config.home.profileDirectory}/bin:/nix/var/nix/profiles/default/bin:${host.homeDirectory}/.local/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
    '';
  };
}
