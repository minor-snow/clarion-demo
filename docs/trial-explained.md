# Trial Explained

## What is `clarion trial`?

`clarion trial` is a command suite that evaluates a repository's readiness for Clarion governance adoption. It runs non-destructively against your existing repo and produces a report.

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

Evaluates recent pull request patterns:
- Change frequency and size distribution
- Review patterns
- Files that change together
- Potential protected-file candidates

### `trial report`

Generates the final adoption report at `.clarion-trial/clarion_trial_report.md`:
- Summary of findings
- Recommended governance rules
- Adoption complexity estimate
- Suggested next steps

### `trial bug` (optional)

Analyzes a specific bug scenario:
- Would governance have caught this?
- Which rules would have triggered?
- What's the counterfactual?

## Output format

All trial subcommands produce JSON envelopes on stdout. The report subcommand additionally writes the markdown report file.

## Safety

Trial is read-only. It never modifies your source files. The only write is the `.clarion-trial/` output directory.
