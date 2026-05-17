# Clarion Demo External Surface Verification

Last refreshed: 2026-05-17
Repo: https://github.com/minor-snow/clarion-demo

This record summarizes the public entrypoints that were manually or
mechanically verified during the latest refresh. It is intentionally descriptive
rather than tied to a single hard-coded commit hash.

## Static checks

| Check | Result |
|-------|--------|
| `bash -n scripts/demo-bite.sh` | pass |
| `bash -n scripts/demo-review-required.sh` | pass |
| `bash -n scripts/demo-trial-empty-repo.sh` | pass |
| `bash -n scripts/trial-on-repo.sh` | pass |
| Workflow YAML parse (`demo-smoke.yml`) | pass |
| Workflow YAML parse (`trust-bite.yml`) | pass |
| Fixture tests (`test_policy_engine.py`) | pass |
| `assert-output-safe.js` on README.md | pass |
| `assert-output-safe.js` on PUBLIC-CONTRACT.md | pass |
| `assert-output-safe.js` on TRY-YOUR-REPO.md | pass |
| `assert-output-safe.js` on docs/conformance-evidence.md | pass |
| `assert-output-safe.js` on docs/safety-boundaries.md | pass |
| `assert-surface-consistency.sh` | pass |

## Trust bite - real run

- Command: `CLARION_BIN=<path>/clarion-linux ./scripts/demo-bite.sh`
- Clarion exit code: 1
- Script exit code: 0
- Verdict: non-pass, observed as `requires_contract` for the current fixture
- `artifacts/bite/result.json`: exists, valid JSON, contains `schema_version`
- `artifacts/bite/bite-report.md`: exists, sanitized summary only
- Raw output embedded in report: **no**
- `assert-output-safe.js` on bite-report.md: pass

### Envelope shape observed

```text
schema_version: pantheon_cli_result@0.1.0
command: pantheon check
target_type: contract_gate
status: failed
verdict: requires_contract
findings: 1 (missing_contract, blocking)
privacy.disclosure: full-local
```

## Review-required demo - real run

- Command: `CLARION_BIN=<path>/clarion-linux ./scripts/demo-review-required.sh`
- Clarion exit code: 1
- Script exit code: 0
- Governance surface: review-required path
- Observed verdict for current fixture: `requires_contract`
- `artifacts/review-required/result.json`: exists, valid JSON
- `artifacts/review-required/review-required-report.md`: exists, sanitized summary only

Important note: this demo proves that a review-required path surfaces a
governance state. The exact verdict depends on current policy and contract
coverage and should not be treated as an unconditional semantic promise.

## Trial on a minimal repo - real run

- Command: `CLARION_BIN=<path>/clarion-linux ./scripts/demo-trial-empty-repo.sh`
- Wrapper exit code: 0
- Summary artifact: `artifacts/trial-empty-repo/empty-repo-summary.md`
- Lane logs: copied into `artifacts/trial-empty-repo/`
- Canonical report path checked: `artifacts/trial-empty-repo/report/clarion_trial_report.md`
- Bridge report path checked: `artifacts/trial-empty-repo/bridge_report.md`

This run verifies that the bare-repo demo now follows the same canonical report
path contract described by `trial-on-repo.sh` and README.

## Surface alignment summary

| Surface | Status |
|---------|--------|
| README entrypoint scripts exist | pass |
| README review-required wording avoids over-promising a single verdict | pass |
| PUBLIC-CONTRACT avoids invented Trial JSON guarantees | pass |
| Trust-bite artifacts (`result.json` + sanitized report) | pass |
| Trial-empty summary uses nested canonical report path | pass |
| Public runtime entrypoints covered in CI when engine is available | pass |
| No absolute paths in public docs | pass |
| No secret-like tokens in public docs | pass |

## Conclusion

The Clarion Demo external surface is materially stronger than the earlier
public snapshot:

- README points to real scripts
- trust-bite artifact contracts are aligned
- review-required is documented as a governance-state demo rather than a fixed verdict promise
- minimal-repo Trial demo uses the correct canonical report path
- CI now covers the missing public runtime entrypoints when the engine is available

Remaining honesty boundary:
- this repo still does not provide a public one-command end-to-end coding-agent runtime demo
