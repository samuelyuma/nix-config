{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "monocode";
  version = "0.16.0";

  src = fetchurl {
    url = "https://github.com/hardbeat920/monocode/releases/download/v${finalAttrs.version}/MonoCode.app.tar.gz";
    hash = "sha256-/BcW6F5NVKz2wqX5hnW92KWwtPowNQK04q/rAufSU1I=";
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
    description = "GUI for coding agents";
    homepage = "https://github.com/hardbeat920/monocode";
    license = lib.licenses.mit;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" ];
  };
})
