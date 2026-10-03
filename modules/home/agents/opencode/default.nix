{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./omo.nix
  ];

  xdg.configFile."opencode/cli.json" = {
    force = true;
    text = builtins.toJSON {
      "$schema" = "https://opencode.ai/v2/cli.json";
      plugins = [ ];
    };
  };

  home.activation.cleanupLegacyTuiJson = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    tui_json="${config.xdg.configHome}/opencode/tui.json"
    if [ -f "$tui_json" ]; then
      if ${pkgs.ripgrep}/bin/rg -q "oh-my-openagent" "$tui_json" 2>/dev/null; then
        $DRY_RUN_CMD rm -f "$tui_json"
      fi
    fi
  '';
}
