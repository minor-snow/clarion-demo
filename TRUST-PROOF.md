# Trust Proof

## What the trust-bite proves

1. **Enforcement is active** — Clarion detects an unchecked change to a protected policy file and produces a non-pass governance result.
2. **Determinism** — Given the same fixture and patch, the result is always the same.
3. **No bypass** — The governance layer cannot be silently skipped by an agent modifying a protected policy file.
4. **Observable output** — The verdict is machine-readable (JSON envelope) and human-readable (report).

## What the trust-bite does NOT prove

1. **Full coverage** — This demo exercises one trust-bite scenario around a protected policy file. Clarion supports many rule types.
2. **Production readiness** — The fixture is minimal. Real repos have more complex governance surfaces.
3. **Network behavior** — The demo runs fully offline. It does not prove anything about remote integrations.
4. **Performance at scale** — The fixture is small. Trial on your own repo to see real-world behavior.

## How to verify independently

1. Read `fixtures/trust-bite-app/pantheon.json` and `fixtures/trust-bite-app/pantheon.alpha.json` — confirms `src/policy_engine.py` is protected by the current public config shape.
2. Read `scenarios/bite/patches/protected-policy-change.patch` — confirms the patch modifies that file.
3. Run `./scripts/demo-bite.sh` — confirms the verdict is non-pass.
4. Inspect `artifacts/bite/bite-report.md` — confirms the report matches expected output.

## Determinism guarantee

The bite demo uses:
- A fixed fixture (no external dependencies)
- A fixed patch (committed to this repo)
- No network calls
- No randomness

The same input always produces the same output.
