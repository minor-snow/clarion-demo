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
4. **Report** — tries to produce the canonical Trial report
5. **Bug** (optional) — if `--bug-title` is provided, runs a trial bug analysis

## Output

The wrapper uses `.clarion-trial/` inside the target repository:

- Canonical report, when produced by Clarion CLI:
  `.clarion-trial/report/clarion_trial_report.md`
- Wrapper-owned fallback, when the canonical report is unavailable:
  `.clarion-trial/bridge_report.md`
- Lane logs:
  `.clarion-trial/trial-*.log`
- Structured lane outputs:
  `.clarion-trial/doctor/`, `.clarion-trial/scan/`, `.clarion-trial/pr/`

If the canonical report is unavailable, the wrapper prints that explicitly and
writes a bridge report instead. The bridge report is not a Clarion Trial report.

Once your PR lane is stable, see [docs/agent-automation-path.md](docs/agent-automation-path.md)
for the recommended path toward governed agent automation.

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

## Troubleshooting

- Ensure the target path is a git repository (has a `.git` directory)
- Ensure at least one commit exists
- See [docs/troubleshooting.md](docs/troubleshooting.md) for common issues
