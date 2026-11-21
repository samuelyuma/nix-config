{ lib, ... }:

let
  regexOf = names: "(${lib.concatStringsSep "|" names})";
  fromInputAt = input: subdir: names: {
    inherit input;
    inherit subdir;
    filter.nameRegex = regexOf names;
  };
  fromInput = input: fromInputAt input "skills";
in
{
  programs.agent-skills = {
    enable = true;
    targets = {
      opencode.enable = true;
      codex.enable = true;
      antigravity = {
        enable = true;
        dest = "$HOME/.gemini/config/skills";
      };
    };

    sources = {
      personal-skills = {
        input = "personal-skills";
        subdir = "skills";
        filter.maxDepth = 1;
      };
      agent-browser = fromInput "agent-browser" [ "agent-browser" ];
      grill = fromInputAt "grill" "skills/productivity" [
        "grilling"
        "writing-for-agents"
      ];
      matt-engineering = fromInputAt "grill" "skills/engineering" [
        "codebase-design"
        "diagnosing-bugs"
        "domain-modeling"
        "grill-with-docs"
        "improve-codebase-architecture"
        "retro"
      ];
      anthropic-skills = fromInput "anthropic-skills" [ "skill-creator" ];
      tactile-design = fromInput "tactile-design" [ "tactile-design" ];
      emil-skills = fromInput "emil-skills" [
        "break-ui"
        "emil-design-eng"
      ];
      security-audit-skill = fromInput "security-audit-skill" [ "security-audit" ];
      impeccable = fromInputAt "impeccable" ".agents/skills" [ "impeccable" ];
    };

    skills.enableAll = true;
  };
}
