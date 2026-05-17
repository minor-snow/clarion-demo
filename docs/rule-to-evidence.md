# Rule-to-Evidence Map

This table maps every governance rule demonstrated in this repository to its
enforcement type and the evidence that verifies it.

| Rule | Type | Evidence in this repo | Status |
|------|------|----------------------|--------|
| Do not modify protected core files | machine enforcement | `demo-bite.sh` → non-pass verdict | verified |
| Review-required surfaces need human attention | governance preview | `demo-review-required.sh` → requires_contract | verified |
| No raw output in public reports | artifact safety | `assert-output-safe.js` | verified |
| No absolute local paths in shared artifacts | artifact safety | `assert-output-safe.js` | verified |
| No raw diff hunks in human-facing docs | artifact safety | `assert-output-safe.js` | verified |
| No secret-like payloads in public docs | artifact safety | `assert-output-safe.js` | verified |
| Automated agent changes must still hit governance verdicts | documented adoption flow | `agent-automation-path.md` + trust-bite / review-required evidence | documented |
| Local-only binding | behavior constraint | `AGENTS.md` + app design | advisory |
| Type discipline (no `any`) | static discipline | project type checks | project-specific |

## Reading this table

**machine enforcement** — Clarion CLI produces a structured verdict. The demo
can reproduce this result deterministically.

**governance preview** — Clarion surfaces a governance state (like `requires_contract`)
that informs but does not block. The demo plans to demonstrate this path.

**artifact safety** — A post-processing check ensures public-facing outputs meet
safety boundaries. This is verified by `assert-output-safe.js` on every CI run.

**behavior constraint** — A rule declared in `AGENTS.md` or project documentation
that shapes AI and human behavior. No machine enforcement exists today; compliance
depends on the contributor following the declared rule.

**project-specific** — Enforcement depends on the target project's toolchain
(linters, type checkers, test suites). Clarion does not enforce this directly
but can surface it in Trial scan results.

## Why this matters

Not every rule is the same strength. This table makes that explicit so users
know exactly what is machine-verified, what is advisory, and what is planned.

Claiming uniform enforcement for all rules would be dishonest. This map is the
honest alternative.
