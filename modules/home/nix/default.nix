{ host, inputs, ... }:

{
  home.packages = [ inputs.self.packages.${host.system}.nxc ];
}
