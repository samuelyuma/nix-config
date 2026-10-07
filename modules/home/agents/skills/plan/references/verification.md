# Plan Verification

Read before delivering any plan. Define how the implementer will demonstrate the requested outcome; planning checks establish plan quality, not completion of future work.

## Define Success

Use observable acceptance criteria tied to the user's behavior and constraints. Include important edge cases, compatibility requirements, and failure behavior when relevant. Avoid criteria that merely repeat the proposed implementation.

Find check commands in repository instructions, scripts, existing tests, or tool documentation. Preserve required project checks and add focused checks where they cover the change. Label proposed new tests and their location. If a command cannot be verified, state that limit and describe the intended check rather than inventing an invocation.

For bug fixes, exercise the actual trigger and confirm expected behavior; an unrelated passing test is insufficient. For refactors, identify behavior to preserve and tests that reach it. For configuration changes, distinguish evaluation or build checks from runtime application. Follow environment-specific permission rules for any execution.

## Check the Plan

Confirm that each consequential change has a meaningful completion check, prerequisites precede dependent work, and important unknowns remain visible. Keep verification proportional: a wording change does not require a new test suite, while a behavioral change needs evidence covering the affected behavior.

List checks actually run with their real outcomes and limits, separately from checks to run during implementation. Inspection, a suggested test, a successful build, and runtime validation establish different things. A ready plan means the work is sufficiently specified; it does not mean the implementation or its tests have passed.
