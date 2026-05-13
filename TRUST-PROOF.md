# Trust Proof

## What the trust-bite proves

1. **Enforcement is active** — Clarion detects an unchecked change to a protected policy file and produces a non-pass governance result.
2. **Governance verdict determinism** — Given the same fixture and patch, the verdict and structured CLI envelope are stable.
3. **No bypass** — The governance layer cannot be silently skipped by an agent modifying a protected policy file.
4. **Observable output** — The result is available as a machine-readable JSON envelope and as a sanitized human-readable report.

## What the trust-bite does NOT prove

1. **Full coverage** — This demo exercises one trust-bite scenario around a protected policy file. Clarion supports many rule types.
2. **Production readiness** — The fixture is minimal. Real repos have more complex governance surfaces.
3. **Network behavior** — The demo runs fully offline. It does not prove anything about remote integrations.
4. **Byte-for-byte report determinism** — `bite-report.md` includes a timestamp, so the markdown report is not byte-identical across runs.

## How to verify independently

1. Read `fixtures/trust-bite-app/pantheon.json` and `fixtures/trust-bite-app/pantheon.alpha.json` — confirms `src/policy_engine.py` is protected by the current compatibility shape.
2. Read `scenarios/bite/patches/protected-policy-change.patch` — confirms the patch modifies that file.
3. Run `./scripts/demo-bite.sh` — confirms the verdict is non-pass.
4. Inspect `artifacts/bite/result.json` — confirms the machine-readable envelope.
5. Inspect `artifacts/bite/bite-report.md` — confirms the sanitized report summary.

## Determinism guarantee

The bite demo uses:
- A fixed fixture (no external dependencies)
- A fixed patch (committed to this repo)
- No network calls
- No randomness in the governance evaluation path

The governance verdict is deterministic for the same input. The markdown report
adds a timestamp and is therefore not byte-for-byte deterministic.
