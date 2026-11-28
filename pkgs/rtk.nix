{
  pkg-config,
  rustPlatform,
  sqlite,
  src,
}:

rustPlatform.buildRustPackage {
  pname = "rtk";
  version = "0.48.0";
  inherit src;
  cargoLock.lockFile = "${src}/Cargo.lock";
  nativeBuildInputs = [ pkg-config ];
  buildInputs = [ sqlite ];
  env.LIBSQLITE3_SYS_USE_PKG_CONFIG = "1";
  doCheck = false;
  meta.mainProgram = "rtk";
}
