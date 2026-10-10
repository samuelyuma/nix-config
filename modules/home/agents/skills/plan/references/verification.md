# Plan Verification

Read before delivering any plan. A plan check shows the plan is sound. It does not show the future work is done.

## Define Success

Use observable acceptance criteria tied to the requested behavior and constraints. Include edge cases, compatibility, and failure behavior where they matter. Do not write criteria that only repeat the implementation.

Find commands in repository instructions, scripts, existing tests, or tool docs. Keep required project checks and add focused ones. Label new tests and where they go. If a command cannot be verified, say the intended check without inventing an invocation.

- Bug fix: exercise the real trigger and confirm the expected behavior. An unrelated passing test is not enough.
- Refactor: name the behavior to preserve and the tests that reach it.
- Config change: separate evaluation or build checks from applying it at runtime.

## Check the Plan

- Each consequential change has a completion check.
- Prerequisites come before dependent work.
- Open decisions are collected in one section and marked at their steps.
- Material unknowns stay visible.
- Detail matches the task: a wording change does not need a new test suite.

## Where Results Go

The plan lists checks to run later. Checks actually run during planning, with their real results and limits, go in the chat reply, not inside the plan. Inspection, a suggested test, a successful build, and a runtime check prove different things. A ready plan means the work is specified, not that it has passed.
