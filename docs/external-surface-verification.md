# Clarion Demo External Surface Verification

Verified: 2026-05-13T13:40Z
Commit: 828e804 (main)
Repo: https://github.com/minor-snow/clarion-demo

## Static checks

| Check | Result |
|-------|--------|
| `bash -n scripts/demo-bite.sh` | pass |
| `bash -n scripts/trial-on-repo.sh` | pass |
| Workflow YAML parse (`demo-smoke.yml`) | pass |
| Workflow YAML parse (`trust-bite.yml`) | pass |
| Fixture tests (`test_policy_engine.py`) | pass (9 tests) |
| `assert-output-safe.js` on README.md | pass |
| `assert-output-safe.js` on PUBLIC-CONTRACT.md | pass |
| `assert-output-safe.js` on TRY-YOUR-REPO.md | pass |
| `assert-output-safe.js` on docs/conformance-evidence.md | pass |
| `assert-output-safe.js` on docs/safety-boundaries.md | pass |

## Trust bite — real run

- Command: `CLARION_BIN=<path>/clarion-linux ./scripts/demo-bite.sh`
- Clarion exit code: 1
- Script exit code: 0 (demo completed successfully)
- Verdict: `requires_contract` (NON-PASS as expected)
- `artifacts/bite/result.json`: exists, valid JSON, contains `schema_version`
- `artifacts/bite/bite-report.md`: exists, sanitized summary only
- Raw output embedded in report: **no**
- `assert-output-safe.js` on bite-report.md: pass

### Envelope shape observed

```
schema_version: pantheon_cli_result@0.1.0
command: pantheon check
target_type: contract_gate
status: failed
verdict: requires_contract
findings: 1 (missing_contract, blocking)
privacy.disclosure: full-local
```

No absolute paths. No raw diff hunks. No secrets.

## Trial bridge — design verification

- Script uses `BRIDGE_REPORT_PATH="$TRIAL_OUT_DIR/bridge_report.md"`
- Canonical report path: `$TRIAL_OUT_DIR/report/clarion_trial_report.md`
- Fallback writes only to `bridge_report.md`, never to canonical path
- Output explicitly states: "This is not a Clarion Trial report."
- Runtime proof deferred: requires a target repo with trial lanes available

Note: An earlier version of the script checked the wrong canonical path
(flat `$TRIAL_OUT_DIR/clarion_trial_report.md` instead of the nested
`report/` subdirectory). This was corrected in the drift audit.
## Surface alignment summary

| Surface | Status |
|---------|--------|
| README three-entry front door | pass |
| PUBLIC-CONTRACT (no invented schema) | pass |
| Trial bridge (separate from canonical) | pass |
| Bite report (no raw output) | pass |
| Conformance evidence (verdict vs report distinction) | pass |
| Fixture path_roles populated | pass |
| No absolute paths in public docs | pass |
| No secret-like tokens in public docs | pass |

## Conclusion

The Clarion Demo external surface is verified for external review / limited publication.

Verified:
- deterministic trust-bite path
- public documentation safety
- separate trial bridge fallback semantics
- no raw output embedded in shareable reports
- no absolute paths, raw diff hunks, or secret-like payloads in public docs/artifacts

Deferred:
- full runtime validation of `trial-on-repo.sh` against a target repository with Trial lanes available

The repository is ready to serve as Clarion's public front door for:
1. seeing Clarion produce a real non-pass governance result,
2. being guided toward `clarion trial` on a user repository,
3. inspecting public-surface expectations and safety boundaries.
