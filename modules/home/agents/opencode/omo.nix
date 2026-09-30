let
  zenFreeModels = [
    "opencode/muse-spark-1.3-contributor-free"
    { model = "opencode/big-pickle"; }
    { model = "opencode/space-bunny-free"; }
    { model = "opencode/longcat-2.5-preview-free"; }
    { model = "opencode/mimo-v2.6-flash-free"; }
    { model = "opencode/ling-3.0-flash-fin-free"; }
    { model = "opencode/nemotron-3-ultra-free"; }
    { model = "opencode/nemotron-3.5-lightning-free"; }
  ];

  omoAgentNames = [
    "sisyphus"
    "hephaestus"
    "oracle"
    "librarian"
    "explore"
    "multimodal-looker"
    "prometheus"
    "metis"
    "momus"
    "atlas"
    "sisyphus-junior"
    "code-reviewer"
  ];

  omoCategoryNames = [
    "visual-engineering"
    "ultrabrain"
    "deep"
    "artistry"
    "quick"
    "unspecified-low"
    "unspecified-high"
    "writing"
  ];

  primaryModel = builtins.head zenFreeModels;
  omoAgents = builtins.listToAttrs (
    map (name: {
      inherit name;
      value.model = primaryModel;
    }) omoAgentNames
  );
  omoCategories = builtins.listToAttrs (
    map (name: {
      inherit name;
      value.models = zenFreeModels;
    }) omoCategoryNames
  );
in
{
  home.file.".omo/omo.jsonc" = {
    force = true;
    text = builtins.toJSON {
      "$schema" =
        "https://raw.githubusercontent.com/code-yeongyu/oh-my-openagent/dev/assets/omo.schema.json";
      "[opencode]" = {
        agents = omoAgents;
        categories = omoCategories;
        codegraph = { };
      };
      "[codex]".codegraph = { };
      codegraph = { };
      _migrations = [
        "2026-07-codex-config-jsonc"
        "2026-08-reasoning-unification"
      ];
    };
  };

}
