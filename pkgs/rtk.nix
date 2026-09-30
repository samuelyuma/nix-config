{ rustPlatform, src }:

rustPlatform.buildRustPackage {
  pname = "rtk";
  version = "0.48.0";
  inherit src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  doCheck = false;
  meta.mainProgram = "rtk";
}
