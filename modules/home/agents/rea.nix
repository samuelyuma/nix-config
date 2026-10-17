{ pkgs, ... }:

{
  # REA requires absolute paths for its native-analysis engine: the Ghidra
  # installation root (nixpkgs keeps the release tree under lib/ghidra) and a
  # full JDK, which its preflight reads from JAVA_HOME before PATH.
  home.sessionVariables = {
    GHIDRA_INSTALL_DIR = "${pkgs.ghidra}/lib/ghidra";
    JAVA_HOME = "${pkgs.jdk21}";
  };
}
