{
  lib,
  buildNpmPackage,
  fetchNpmDeps,
  fetchurl,
  runCommand,
}:

let
  version = "6.5.0";

  # The registry tarball ships the prebuilt `dist` output without a lockfile,
  # so the matching release tag provides the dependency lock for `npm ci`.
  lockfileSrc = runCommand "rea-agents-${version}-lockfile" { } ''
    mkdir -p $out
    cp ${
      fetchurl {
        url = "https://raw.githubusercontent.com/morluto/rea/rea-agents-${version}/package.json";
        hash = "sha256-pQAwIxnBIUqLtsmotKSgkIBule74hCBKnZ+7QAMFCmw=";
      }
    } $out/package.json
    cp ${
      fetchurl {
        url = "https://raw.githubusercontent.com/morluto/rea/rea-agents-${version}/package-lock.json";
        hash = "sha256-BIIIU3LFY8mbMlGfUTOesoCtwr2D79umqO/XzUpJ6fA=";
      }
    } $out/package-lock.json
  '';
in
buildNpmPackage {
  pname = "rea-agents";
  inherit version;

  src = fetchurl {
    url = "https://registry.npmjs.org/rea-agents/-/rea-agents-${version}.tgz";
    hash = "sha256-UxcXoG6SymUaq1JpEZD5FvrARCcsAfh14ixeKTIY5pk=";
  };

  npmDeps = fetchNpmDeps {
    src = lockfileSrc;
    hash = "sha256-EQKhS1S7Hsfjbo5GikMeAFc2HFtALsDcw6XnJATUryw=";
  };

  postPatch = ''
    cp ${lockfileSrc}/package-lock.json package-lock.json
  '';

  # Install runtime dependencies only. Scripts stay disabled: nothing needs
  # compiling, and the optional frida binding is downloaded at install time.
  # REA treats frida as optional and reports it as unavailable.
  npmInstallFlags = [ "--omit=dev" ];
  npmRebuildFlags = [ "--ignore-scripts" ];
  npmPackFlags = [ "--ignore-scripts" ];

  dontNpmBuild = true;

  meta = {
    description = "Reverse engineering CLI and MCP server for agents";
    homepage = "https://github.com/morluto/rea";
    license = lib.licenses.mit;
    mainProgram = "rea";
  };
}
