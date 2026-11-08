{ host, lib, ... }:

{
  imports = [
    ./common.nix
  ]
  ++ lib.optionals (host.profile == "darwin") [ ./darwin.nix ]
  ++ lib.optionals (host.profile == "linux") [ ./linux.nix ];
}
