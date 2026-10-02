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
    targets.opencode.enable = true;
    targets.codex.enable = true;

    sources = {
      local.path = ./skills;
      ponytail = fromInput "ponytail" [
        "ponytail"
        "ponytail-review"
      ];
      superpowers = fromInput "superpowers" [ "verification-before-completion" ];
      i-have-adhd = fromInput "i-have-adhd" [ "i-have-adhd" ];
      humanizer.input = "humanizer";
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
        "tdd"
        "to-tickets"
        "research"
        "to-spec"
      ];
      anthropic-skills = fromInput "anthropic-skills" [ "skill-creator" ];
    };

    skills.enableAll = true;
  };
}
