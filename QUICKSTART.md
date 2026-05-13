# Quickstart — See the Bite

Get from zero to a governance enforcement demo in under 5 minutes.

## Prerequisites

- Bash (macOS/Linux or Git Bash on Windows)
- Git
- `clarion` binary on PATH (or set `CLARION_BIN` env var)

## Steps

1. Clone this repo:

```bash
git clone https://github.com/anthropic/clarion-demo.git
cd clarion-demo
```

2. Run the bite demo:

```bash
./scripts/demo-bite.sh
```

3. Read the output. You will see:
   - A protected file (`src/policy_engine.py`) was modified
   - Clarion returned a **non-pass** verdict
   - A report was generated at `artifacts/bite/bite-report.md`

## What happened

The demo applied a patch to a file marked as protected in `pantheon.json`. Clarion detected the violation and produced a governance verdict that is not `pass`.

This proves the enforcement layer is active and deterministic.

## Next steps

- Read [TRUST-PROOF.md](TRUST-PROOF.md) to understand what this proves
- Run [trial on your own repo](TRY-YOUR-REPO.md)
- Inspect the [public contract](PUBLIC-CONTRACT.md)
