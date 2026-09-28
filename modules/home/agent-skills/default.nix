_: {
  programs.agent-skills = {
    enable = true;
    targets.opencode.enable = true;
    targets.codex.enable = true;

    sources = {
      ponytail = {
        input = "ponytail";
        subdir = "skills";
        filter.nameRegex = "(ponytail|ponytail-audit|ponytail-help|ponytail-review|ponytail-gain|ponytail-debt)";
      };
      caveman = {
        input = "caveman";
        subdir = "skills";
        filter.nameRegex = "(caveman|caveman-help|caveman-evidence-review|caveman-explore|caveman-learn|caveman-review|caveman-compress|caveman-manage|caveman-setup|caveman-optimize|caveman-discover|caveman-stats|caveman-commit|investigate-first|surgical-patch|safe-refactor|verify-and-stop|cavecrew|lean-build|migration)";
      };
      superpowers = {
        input = "superpowers";
        subdir = "skills";
        filter.nameRegex = "(using-git-worktrees|test-driven-development|systematic-debugging|using-superpowers|dispatching-parallel-agents|executing-plans|finishing-a-development-branch|brainstorming|diagnosing-superpowers|writing-plans|requesting-code-review|receiving-code-review|writing-skills|verification-before-completion|subagent-driven-development)";
      };
      i-have-adhd = {
        input = "i-have-adhd";
        subdir = "skills";
        filter.nameRegex = "i-have-adhd";
      };
      humanizer = {
        input = "humanizer";
      };
      grill = {
        input = "grill";
        subdir = "skills";
        filter.nameRegex = "(grill-me|batch-grill-me)";
      };
    };

    skills.enableAll = true;
  };
}
