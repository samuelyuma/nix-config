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
        "ponytail-audit"
        "ponytail-help"
        "ponytail-review"
        "ponytail-gain"
        "ponytail-debt"
      ];
      caveman = fromInput "caveman" [
        "caveman"
        "caveman-help"
        "caveman-evidence-review"
        "caveman-explore"
        "caveman-learn"
        "caveman-review"
        "caveman-compress"
        "caveman-manage"
        "caveman-setup"
        "caveman-optimize"
        "caveman-discover"
        "caveman-stats"
        "caveman-commit"
        "surgical-patch"
        "safe-refactor"
        "cavecrew"
        "lean-build"
        "migration"
      ];
      superpowers = fromInput "superpowers" [
        "using-git-worktrees"
        "test-driven-development"
        "systematic-debugging"
        "using-superpowers"
        "dispatching-parallel-agents"
        "executing-plans"
        "finishing-a-development-branch"
        "brainstorming"
        "diagnosing-superpowers"
        "writing-plans"
        "requesting-code-review"
        "receiving-code-review"
        "verification-before-completion"
        "subagent-driven-development"
      ];
      i-have-adhd = fromInput "i-have-adhd" [ "i-have-adhd" ];
      humanizer.input = "humanizer";
      grill = fromInputAt "grill" "skills/productivity" [
        "writing-for-agents"
      ];
      matt-engineering = fromInputAt "grill" "skills/engineering" [
        "research"
        "to-spec"
      ];
      scientific-agent-skills = fromInput "scientific-agent-skills" [ "markdown-mermaid-writing" ];
      vercel-skills = fromInput "vercel-skills" [ "find-skills" ];
      anthropic-skills = fromInput "anthropic-skills" [ "skill-creator" ];
      bahasa-indonesia-skill = fromInput "bahasa-indonesia-skill" [ "bahasa-indonesia" ];
      scandinavian-design = fromInput "scandinavian-design" [ "scandinavian-design" ];
      taste-skill = {
        input = "taste-skill";
        subdir = "skills";
        filter.nameRegex = "^$";
      };
    };

    skills.enableAll = true;
    skills.explicit.design-taste-frontend = {
      from = "taste-skill";
      path = "taste-skill";
    };
  };
}
