let
  username = "yumx";
  darwinHome = "/Users/${username}";
  vpsHome = "/home/${username}";
in
{
  darwin = {
    name = "darwin";
    profile = "darwin";
    inherit username;
    homeDirectory = darwinHome;
    dotfilesDirectory = "${darwinHome}/Code/nix-config";
    system = "aarch64-darwin";
    githubGitCredentials = true;
  };

  vps = {
    name = "vps";
    profile = "linux";
    inherit username;
    homeDirectory = vpsHome;
    dotfilesDirectory = "${vpsHome}/nix-config";
    system = "x86_64-linux";
    githubGitCredentials = true;
  };
}
