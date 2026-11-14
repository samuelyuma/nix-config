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
      personal-skills = fromInput "personal-skills" [
        "agent-instructions"
        "documentation"
        "plan"
        "research"
        "writing"
      ];
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
    };

    skills.enableAll = true;
  };
}
