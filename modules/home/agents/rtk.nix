_:

{
  xdg.configFile."opencode/AGENTS.md".source = ./global-agents.md;
  home.file.".codex/AGENTS.md".text =
    builtins.readFile ./global-agents.md + "\n" + builtins.readFile ./rtk-codex.md;
}
