{ inputs, ... }:

{
  xdg.configFile."opencode/plugins/rtk.ts".source = "${inputs.rtk}/hooks/opencode/rtk.ts";
  home.file.".codex/AGENTS.md".source = ./rtk-codex.md;
}
