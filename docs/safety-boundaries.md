# Safety Boundaries

Clarion is designed with strict safety boundaries. These are not configurable -
they are architectural constraints.

## 1. No code execution

Clarion never executes code from the repository it is checking. It reads files
and analyzes structure, but does not run tests, build scripts, or user code as
part of governance evaluation.

**Why:** Executing arbitrary repository code would be a security risk. Governance
checks must be safe to run on untrusted code.

## 2. No network calls

Clarion checks run fully offline. No data is sent to external services during
`check` or `trial` operations.

**Why:** Governance decisions must be deterministic and not depend on external
state. Network failures must not block governance.

## 3. No source mutation

Clarion does not modify source files in the repository under evaluation.

The only writes shown by this public front door are local output artifacts:
- `.clarion-trial/` for Trial wrapper logs and reports
- `artifacts/bite/` for local trust-bite evidence
- stdout/stderr for command output

**Why:** A governance tool that mutates source would violate its own trust
boundary.

## 4. Deterministic governance verdicts

Given the same repository state and configuration, Clarion produces the same
governance verdict. There is no randomness, no time-dependent decision logic,
and no external state dependency in the evaluation path.

**Why:** Non-deterministic governance is not governance. Teams must be able to
predict and reproduce results.

## 5. Bounded runtime

Clarion checks complete in time proportional to repository size. There are no
unbounded loops, no recursive expansion, and no operations that scale
super-linearly in the public demo flow.

**Why:** Governance checks run in CI. They must not block pipelines indefinitely.

## Verification

These boundaries are verified by:
- The trust-bite demo, which proves enforcement without running repository code
- `scripts/assert-output-safe.js`, which blocks path and secret leakage in public artifacts
- `scripts/assert-no-runtime-state.sh`, which blocks committed runtime artifacts
- CI workflows, which continuously re-run the public checks
