{ lib, ... }:

let
  regexOf = names: "(${lib.concatStringsSep "|" names})";
  fromInput = input: names: {
    inherit input;
    subdir = "skills";
    filter.nameRegex = regexOf names;
  };
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
        "investigate-first"
        "surgical-patch"
        "safe-refactor"
        "verify-and-stop"
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
        "writing-skills"
        "verification-before-completion"
        "subagent-driven-development"
      ];
      i-have-adhd = fromInput "i-have-adhd" [ "i-have-adhd" ];
      humanizer.input = "humanizer";
      grill = fromInput "grill" [
        "grill-me"
        "batch-grill-me"
      ];
    };

    skills.enableAll = true;
  };
}
