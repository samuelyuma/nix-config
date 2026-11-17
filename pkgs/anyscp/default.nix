{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "anyscp";
  version = "0.11.1";

  src = fetchurl {
    url = "https://github.com/macnev2013/anySCP/releases/download/v${finalAttrs.version}/anySCP_aarch64.app.tar.gz";
    hash = "sha256-eaivr/Trah6Cm8/R+iLWlh+cuoWStQl6VgJTtRAbZ10=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    tar -xzf "$src" -C "$out/Applications"
    runHook postInstall
  '';

  meta = {
    description = "SSH terminal, SFTP file manager and cloud storage browser";
    homepage = "https://anyscp.com";
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" ];
  };
})
