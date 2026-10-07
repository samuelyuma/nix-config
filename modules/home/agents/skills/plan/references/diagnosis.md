# Diagnosis for Bug Plans

Read for bug fixes, unexplained failures, or performance regressions. This reference is self-contained. Its purpose is to support a defensible plan, not to carry out an unrequested fix.

## Establish the Symptom

Separate expected behavior from observed behavior. Inspect the relevant code path, caller, configuration, existing tests, and safe diagnostic evidence. Record the trigger and conditions. Use supplied traces as evidence with their limits; never read secrets or request credential-bearing artifacts.

Seek a bounded feedback loop that detects the user's actual symptom: an existing test, CLI invocation, request, or other suitable check. Run safe, permitted checks when useful; preserve exact commands and actual results. A suggested reproduction is not an observed failure. A nearby failing test may describe a different bug.

Reduce inputs or conditions while preserving the symptom when this would distinguish causes. For intermittent failures, record attempts and failure frequency under stated conditions; avoid claiming determinism from a successful run. For performance, define the workload, environment, metric, and baseline before proposing an optimization.

## Distinguish Causes

Keep plausible causes as hypotheses until supported. For each consequential hypothesis, state a prediction and the smallest probe that could distinguish it from alternatives. Prefer focused inspection or a controlled experiment; change one relevant variable at a time. Use targeted instrumentation only within existing authorization and plan its cleanup.

Do not require a fixed number of hypotheses or an elaborate harness for an obvious, well-supported cause. When reproduction is unavailable, useful static evidence can support a conditional plan; clearly state what it establishes and what remains unverified.

## Plan the Next Work

For a supported cause, plan a scoped correction and a regression check that exercises the actual trigger. Include the original scenario as well as a reduced test when they cover different risks.

For an unresolved cause, lead with investigation steps: obtain missing evidence, establish the symptom check, test predictions, and reassess. State what result enables selecting a fix; keep candidate fixes conditional. Independent work can proceed, while cause-dependent changes wait for evidence.

If a necessary environment or safe artifact is unavailable, mark the affected steps blocked and ask only for what unlocks them. Avoid repeated probes that add no evidence. Suggested tests, probes, cleanup, and measurements remain future work until actually performed.
