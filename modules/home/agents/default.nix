{ host, lib, ... }:

{
  imports = [
    ./opencode
    ./rtk.nix
    ./skills.nix
  ]
  ++ lib.optionals (host.profile == "linux") [ ./mcp.nix ];
}
