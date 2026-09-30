# RTK

Shell commands go through `rtk`, a CLI proxy that filters noisy output to save tokens.

- Prefix shell commands with `rtk`, for example `rtk git status`, `rtk git diff`,
  and `rtk ls`. Run `rtk --help` to see what is supported.
- Check savings with `rtk gain`.
- If filtered output hides detail you need, re-run the raw command without the prefix.
