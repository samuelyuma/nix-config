{
  lib,
  stdenv,
  stdenvNoCC,
  fetchurl,
  gnutar,
  makeWrapper,
  ripgrep,
  autoPatchelfHook,
}:
let
  inherit (stdenvNoCC) hostPlatform;
  inherit (hostPlatform) isDarwin;

  platform =
    if isDarwin && hostPlatform.isAarch64 then
      "darwin-arm64"
    else if hostPlatform.isLinux && hostPlatform.isx86_64 then
      "linux-x64"
    else
      throw "opencode: unsupported platform ${hostPlatform.system}";
in
stdenvNoCC.mkDerivation (finalAttrs: {
  pname = "opencode";
  version = "2.1.4";

  src = fetchurl {
    url = "https://registry.npmjs.org/@opencode/cli-${platform}/-/cli-${platform}-${finalAttrs.version}.tgz";
    hash =
      if isDarwin then
        "sha256-2qL+BPJ4hQkNzK7tng1lFLyAp4ScywqdlFIbODhRv6U="
      else
        "sha256-zgWr4tzhBBORyOyM242gZvZA/UcecqyEbcsInEQeEeE=";
  };

  dontUnpack = true;
  dontConfigure = true;
  dontBuild = true;
  dontStrip = true;

  nativeBuildInputs = [
    gnutar
    makeWrapper
  ]
  ++ lib.optional (!isDarwin) autoPatchelfHook;

  buildInputs = lib.optionals (!isDarwin) [ stdenv.cc.cc.lib ];

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
    platforms = [
      "aarch64-darwin"
      "x86_64-linux"
    ];
  };
})
