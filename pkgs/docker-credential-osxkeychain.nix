{
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "docker-credential-osxkeychain";
  version = "0.9.9";

  src = fetchurl {
    url = "https://github.com/docker/docker-credential-helpers/releases/download/v${finalAttrs.version}/docker-credential-osxkeychain-v${finalAttrs.version}.darwin-arm64";
    hash = "sha256-NYUYix3xw1aK5TaZnt20itLHgbPPB6L31xgSYtBFggw=";
  };

  dontUnpack = true;

  installPhase = ''
    runHook preInstall
    install -Dm755 $src $out/bin/docker-credential-osxkeychain
    runHook postInstall
  '';

  meta.mainProgram = "docker-credential-osxkeychain";
})
