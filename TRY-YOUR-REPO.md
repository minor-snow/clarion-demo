# Try Clarion on Your Own Repo

Run `clarion trial` against any repository to get an adoption report.

## Prerequisites

- Bash (macOS/Linux or Git Bash on Windows)
- Git
- `clarion` binary on PATH (or set `CLARION_BIN` env var)
- A git repository you want to evaluate

## Usage

```bash
./scripts/trial-on-repo.sh /path/to/your/repo
```

### With bug title (optional)

```bash
./scripts/trial-on-repo.sh /path/to/your/repo --bug-title "Memory leak in auth module"
```

## What it does

1. **Doctor** — checks your repo meets minimum requirements
2. **Scan** — analyzes repository structure and identifies governance surfaces
3. **PR** — evaluates recent pull request patterns
4. **Report** — attempts to generate `.clarion-trial/clarion_trial_report.md`
5. **Bug** (optional) — if `--bug-title` is provided, runs a trial bug analysis

## Examples

### Python project

```bash
./scripts/trial-on-repo.sh ~/projects/my-flask-app
```

### TypeScript project

```bash
./scripts/trial-on-repo.sh ~/projects/my-next-app
```

### Monorepo with bug analysis

```bash
./scripts/trial-on-repo.sh ~/projects/platform --bug-title "Race condition in queue worker"
```

## Output

The trial report is written to:

```
/path/to/your/repo/.clarion-trial/clarion_trial_report.md
```

See [docs/interpreting-trial-report.md](docs/interpreting-trial-report.md) for how to read the report.

If the canonical `clarion trial report` output is unavailable for your repo state,
the wrapper writes a fallback bridge report at the same path and stores step logs
under `.clarion-trial/`.

## Troubleshooting

- Ensure the target path is a git repository (has a `.git` directory)
- Ensure at least one commit exists
- See [docs/troubleshooting.md](docs/troubleshooting.md) for common issues
