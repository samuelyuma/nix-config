{
  stdenvNoCC,
  fetchurl,
}:

stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "workshop-runner";
  version = "0.2.5";

  src = fetchurl {
    url = "https://github.com/mainmatter/rust-workshop-runner/releases/download/v${finalAttrs.version}/workshop-runner-aarch64-apple-darwin.tar.xz";
    hash = "sha256-K9j4iomv2sKTES80Zt7UxOgmK1KScdSbhsSAhk8UfJ4=";
  };

  installPhase = ''
    runHook preInstall
    install -Dm755 wr $out/bin/wr
    runHook postInstall
  '';

  meta.mainProgram = "wr";
})
