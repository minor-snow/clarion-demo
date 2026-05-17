#!/usr/bin/env bash
set -euo pipefail

# demo-trial-empty-repo.sh - Show the realistic Trial experience on a bare repo
#
# Most repos do not have ARCHITECTURE.md, AGENTS.md, pantheon.json, or CI on day one.
# This demo runs `clarion trial` against a minimal fixture so users can see the
# real shape of the output before they install Clarion in their own repo.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

CLARION="${CLARION_BIN:-clarion}"
FIXTURE="$REPO_ROOT/fixtures/minimal-repo"
ARTIFACTS_DIR="$REPO_ROOT/artifacts/trial-empty-repo"

if ! "$CLARION" --version >/dev/null 2>&1; then
  echo "ERROR: clarion binary is not runnable: $CLARION"
  exit 2
fi

# --- Setup temp workspace ---
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "=== Clarion Trial - minimal repo demo ==="
echo ""
echo "This demo shows what Trial looks like on a typical first-time repo."
echo "There is no ARCHITECTURE.md, no AGENTS.md, no CI, no test suite."
echo "This is the realistic state, not the happy path."
echo ""
echo "1. Copying minimal-repo fixture..."
cp -r "$FIXTURE/." "$WORK/"

echo "2. Initializing git repository..."
cd "$WORK"
git init -q
git add -A
git -c user.name="clarion-demo" -c user.email="clarion-demo@example.invalid" commit -q -m "Initial commit"

echo "3. Running trial-on-repo wrapper..."
echo ""

# Use the existing wrapper so the demo matches the user-facing path
mkdir -p "$ARTIFACTS_DIR"
set +e
"$REPO_ROOT/scripts/trial-on-repo.sh" "$WORK" 2>&1 | tee "$ARTIFACTS_DIR/run.log"
WRAPPER_CODE=${PIPESTATUS[0]}
set -e

echo ""
echo "Wrapper exit code: $WRAPPER_CODE"
echo ""

# --- Capture artifacts ---
if [ -d "$WORK/.clarion-trial" ]; then
  cp -r "$WORK/.clarion-trial/." "$ARTIFACTS_DIR/"
fi

# --- Generate summary ---
CANONICAL_FOUND="no"
BRIDGE_FOUND="no"
CANONICAL_REPORT_PATH="$ARTIFACTS_DIR/report/clarion_trial_report.md"
BRIDGE_REPORT_PATH="$ARTIFACTS_DIR/bridge_report.md"
[ -f "$CANONICAL_REPORT_PATH" ] && CANONICAL_FOUND="yes"
[ -f "$BRIDGE_REPORT_PATH" ] && BRIDGE_FOUND="yes"

READ_GUIDANCE="Neither a canonical report nor a bridge report was found. Read the lane logs to understand what happened."
if [ "$CANONICAL_FOUND" = "yes" ]; then
  READ_GUIDANCE="A canonical Trial report was produced. Read \`artifacts/trial-empty-repo/report/clarion_trial_report.md\` first, then inspect the lane logs for supporting detail."
elif [ "$BRIDGE_FOUND" = "yes" ]; then
  READ_GUIDANCE="The canonical report was not produced. Read the bridge report's \"Lane Status\" table to see which governance lanes are reachable today and what the recommended next step is."
fi

cat > "$ARTIFACTS_DIR/empty-repo-summary.md" << EOF
# Trial on a Minimal Repo - Summary

Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

## What this demo shows

A repository with no governance config, no architecture doc, no CI, and no test
suite is the most common first-encounter state. This summary captures what
Clarion Trial actually produces in that state.

## Outcome

- Wrapper exit code: $WRAPPER_CODE
- Canonical Trial report produced: $CANONICAL_FOUND
- Bridge report produced: $BRIDGE_FOUND
- Lane logs available under: \`artifacts/trial-empty-repo/\`

## How to read this

$READ_GUIDANCE

This is what most users will see the first time they run \`clarion trial\` on
their own repository. The next step is not to feel discouraged - it is to add
the smallest piece of governance surface that unlocks the most useful lane
(usually \`AGENTS.md\` + a small \`pantheon.json\`).

## Source of authority

This result comes from the Clarion CLI lanes that ran during this demo, plus
the bridge report when the canonical report was unavailable.

- Clarion CLI invocations: see \`artifacts/trial-empty-repo/trial-*.log\`
- Bridge report (if any): \`artifacts/trial-empty-repo/bridge_report.md\`
- Canonical report (if any): \`artifacts/trial-empty-repo/report/clarion_trial_report.md\`
EOF

echo "4. Summary written to: artifacts/trial-empty-repo/empty-repo-summary.md"
echo ""
echo "=== Demo complete ==="
