rec {
  username = "yumx";
  homeDirectory = "/Users/${username}";
  dotfilesDirectory = "${homeDirectory}/Code/nix-config";
  system = "aarch64-darwin";
  githubGitCredentials = true;
}
