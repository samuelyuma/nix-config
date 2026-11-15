{
  lib,
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "kiri";
  version = "0.2.1";

  src = fetchurl {
    url = "https://github.com/libracoder/kiri/releases/download/v${finalAttrs.version}/Kiri-${finalAttrs.version}-arm64.tar.gz";
    hash = "sha256-e+HCiwjy50rC70+JcqPalR+JpONfEKRh3Oyw+tm5SvI=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontFixup = true;

  # The bundle is signed and notarized upstream. Kiri's own updater stages
  # releases beside the app, which is a read-only store path here, so upgrades
  # belong to `version`/`hash` above. Re-run `kiri setup` after a bump because
  # the login agent records the resolved store path.
  installPhase = ''
    runHook preInstall
    mkdir -p "$out/Applications"
    tar -xzf "$src" -C "$out/Applications"
    # GNU tar materialises the archive's AppleDouble members as `._*` files,
    # which break the code signature's resource seal. Drop them.
    find "$out/Applications" -name '._*' -delete
    mkdir -p "$out/bin"
    ln -s "$out/Applications/Kiri.app/Contents/MacOS/kiri" "$out/bin/kiri"
    runHook postInstall
  '';

  meta = {
    description = "Small container runtime with a Docker-compatible API";
    homepage = "https://github.com/libracoder/kiri";
    license = lib.licenses.asl20;
    sourceProvenance = [ lib.sourceTypes.binaryNativeCode ];
    platforms = [ "aarch64-darwin" ];
    mainProgram = "kiri";
  };
})
