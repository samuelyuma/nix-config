{
  config,
  lib,
  pkgs,
  ...
}:

let
  basicMemoryVersion = "0.23.2";
in
{
  home.activation.installBasicMemory = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    export PATH="${config.home.homeDirectory}/.local/bin:$PATH"
    basic_memory="${config.home.homeDirectory}/.local/bin/basic-memory"
    installed_version=""
    if [ -x "$basic_memory" ]; then
      installed_version="$($basic_memory --version 2>/dev/null | ${pkgs.gawk}/bin/awk '{ print $NF }' || true)"
    fi
    if [ "$installed_version" != "${basicMemoryVersion}" ]; then
      $DRY_RUN_CMD ${pkgs.uv}/bin/uv tool install --force "basic-memory==${basicMemoryVersion}" \
        || echo "warning: basic-memory install failed (offline?) - rerun activation later"
    fi
  '';
}
