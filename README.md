# Clarion Demo

Clarion governs AI-assisted code changes with executable checks, review boundaries, and adoption reports.

This repository is the public front door for trying Clarion.

## Choose your path

### 1. See Clarion enforce a rule

```bash
./scripts/demo-bite.sh
```

You will see a protected policy-file change produce a non-pass result.

### 2. Try Clarion on your own repo

```bash
./scripts/trial-on-repo.sh /path/to/your/repo
```

This runs `clarion trial` and generates `.clarion-trial/clarion_trial_report.md`.

### 3. Inspect the public contract

Read:
- [PUBLIC-CONTRACT.md](PUBLIC-CONTRACT.md)
- [docs/conformance-evidence.md](docs/conformance-evidence.md)
- [docs/safety-boundaries.md](docs/safety-boundaries.md)

---

## What this repo is

- The first public-facing entrypoint for Clarion
- A deterministic trust proof
- A guided bridge into `clarion trial`
- A curated evidence index

## What this repo is NOT

- Not the Clarion source repository
- Not the full conformance harness
- Not a replacement for `clarion trial`
- Not a fake fixture pretending to be product state
