let
  username = "yumx";
  darwinHome = "/Users/${username}";
  linuxHome = "/home/${username}";
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

  linux = {
    name = "linux";
    profile = "linux";
    inherit username;
    homeDirectory = linuxHome;
    dotfilesDirectory = "${linuxHome}/nix-config";
    system = "x86_64-linux";
    githubGitCredentials = true;
  };
}
