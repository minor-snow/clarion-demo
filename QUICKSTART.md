# Quickstart - See the Bite

Get from zero to a governance enforcement demo in under 5 minutes.

## Prerequisites

- Bash (macOS/Linux or Git Bash on Windows)
- Git
- `clarion` binary on PATH (or set `CLARION_BIN` env var)

## Steps

1. Clone this repo:

```bash
git clone https://github.com/minor-snow/clarion-demo.git
cd clarion-demo
```

2. Run the bite demo:

```bash
./scripts/demo-bite.sh
```

3. Read the output. You will see:
- A protected policy file (`src/policy_engine.py`) was modified
- Clarion returned a non-pass governance result
- A sanitized report was generated at `artifacts/bite/bite-report.md`
- A machine-readable envelope was generated at `artifacts/bite/result.json`

## What happened

The demo applies a patch to a file marked as protected in `pantheon.json` and
`pantheon.alpha.json`. Clarion evaluates the resulting diff and returns a
governance result that is not `pass`.

This proves the enforcement layer is active. The governance verdict is
deterministic for the same input; the markdown report includes a timestamp.

## Next steps

- Read [TRUST-PROOF.md](TRUST-PROOF.md) to understand what this proves
- Run [trial on your own repo](TRY-YOUR-REPO.md)
- Inspect the [public contract](PUBLIC-CONTRACT.md)
