# Trial Explained

## What is `clarion trial`?

`clarion trial` is a command suite that evaluates a repository's readiness for Clarion governance adoption. It runs non-destructively against your existing repo and produces adoption signals.

One of those adoption outcomes is whether the repository is ready for governed
agent automation. Trial is not the agent runtime itself; it is part of the path
that tells you whether the agent lane should be enabled yet.

## Trial subcommands

### `trial doctor`

Checks prerequisites:
- Is this a git repository?
- Does it have commits?
- Are there files to analyze?
- Is the repo in a usable state?

### `trial scan`

Analyzes repository structure:
- Identifies governance-relevant files (configs, CI, policies)
- Maps file ownership patterns
- Detects existing protection mechanisms
- Estimates governance surface area

### `trial pr`

Evaluates current or recent change patterns:
- Governance-relevant paths in the diff
- Review-sensitive files
- Potential protected-file candidates

### `trial report`

Generates the canonical adoption report at `.clarion-trial/report/clarion_trial_report.md` when the current lane state is sufficient.

### `trial bug` (optional)

Analyzes a specific bug scenario:
- Would governance have caught this?
- Which rules would have triggered?
- What's the counterfactual?

## Output format in this public demo

This repo demonstrates Trial primarily as a human-readable adoption flow.

Do not treat JSON envelopes as guaranteed for Trial lanes unless the shipped CLI
actually emits them. The wrapper in this repo records lane logs under
`.clarion-trial/trial-*.log` and may synthesize `.clarion-trial/bridge_report.md`
when the canonical Trial report is unavailable.

## Safety

Trial is read-only with respect to your source tree. The public wrapper writes
only under `.clarion-trial/`.

For the full governed agent loop that Trial is meant to unlock, see
[agent-automation-path.md](agent-automation-path.md).
