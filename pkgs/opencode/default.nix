{
  lib,
  stdenvNoCC,
  fetchurl,
  gnutar,
  makeWrapper,
  ripgrep,
}:
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "opencode";
  version = "2.1.4";

  src = fetchurl {
    url = "https://registry.npmjs.org/@opencode/cli-darwin-arm64/-/cli-darwin-arm64-${finalAttrs.version}.tgz";
    hash = "sha256-2qL+BPJ4hQkNzK7tng1lFLyAp4ScywqdlFIbODhRv6U=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  nativeBuildInputs = [
    gnutar
    makeWrapper
  ];

  installPhase = ''
    runHook preInstall

    tar -xzf "$src" -C "$TMPDIR" package/bin/opencode
    install -Dm755 "$TMPDIR/package/bin/opencode" "$out/libexec/opencode"

    makeWrapper "$out/libexec/opencode" "$out/bin/opencode" \
      --set OPENCODE_DISABLE_AUTOUPDATE true \
      --prefix PATH : "${lib.makeBinPath [ ripgrep ]}"

    runHook postInstall
  '';

  meta = {
    description = "AI coding agent built for the terminal";
    homepage = "https://opencode.ai/";
    license = lib.licenses.mit;
    mainProgram = "opencode";
    platforms = [ "aarch64-darwin" ];
  };
})
