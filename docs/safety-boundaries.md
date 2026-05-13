# Safety Boundaries

Clarion is designed with strict safety boundaries. These are not configurable — they are architectural constraints.

## 1. No code execution

Clarion never executes code from the repository it is checking. It reads files and analyzes structure, but does not run tests, build scripts, or any user code.

**Why:** Executing arbitrary code from a repository would be a security risk. Governance checks must be safe to run on untrusted code.

## 2. No network calls

All Clarion checks run fully offline. No data is sent to external services during `check` or `trial` operations.

**Why:** Governance decisions must be deterministic and not depend on external state. Network failures must not block governance.

## 3. No file mutation

Clarion never modifies source files in the repository. The only writes are:
- `.clarion-trial/` directory (trial report output)
- stdout/stderr (envelope output)

**Why:** A governance tool that modifies code would be a governance violation itself.

## 4. Deterministic output

Given the same repository state and configuration, Clarion always produces the same verdict. There is no randomness, no time-dependent logic, and no external state dependency.

**Why:** Non-deterministic governance is not governance. Teams must be able to predict and reproduce results.

## 5. Bounded runtime

Clarion checks complete in time proportional to repository size. There are no unbounded loops, no recursive expansion, and no operations that scale super-linearly.

**Why:** Governance checks run in CI. They must not block pipelines indefinitely.

## Verification

These boundaries are verified by:
- The trust-bite demo (proves enforcement without code execution)
- The `assert-output-safe.js` script (proves no path/secret leakage)
- The `assert-no-runtime-state.sh` script (proves no committed artifacts)
- CI workflows (continuous verification)
