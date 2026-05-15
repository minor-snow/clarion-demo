#!/usr/bin/env bash
set -euo pipefail

# demo-review-required.sh — Run the review-required demo
#
# Copies the fixture to a temp directory, applies a change to a review-required
# file, runs clarion check against the resulting diff, and shows the governance
# state (requires_contract or equivalent).

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

CLARION="${CLARION_BIN:-clarion}"
FIXTURE="$REPO_ROOT/fixtures/trust-bite-app"
PATCH="$REPO_ROOT/scenarios/review-required/patches/review-required-adapter-change.patch"
ARTIFACTS_DIR="$REPO_ROOT/artifacts/review-required"
RESULT_JSON="$ARTIFACTS_DIR/result.json"

if ! "$CLARION" --version >/dev/null 2>&1; then
  echo "ERROR: clarion binary is not runnable: $CLARION"
  exit 2
fi

# --- Setup temp workspace ---
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "=== Clarion Review-Required Demo ==="
echo ""
echo "1. Copying fixture to temp workspace..."
cp -r "$FIXTURE/." "$WORK/"

echo "2. Initializing git repository..."
cd "$WORK"
git init -q
git add -A
git -c user.name="clarion-demo" -c user.email="clarion-demo@example.invalid" commit -q -m "Initial commit: trust-bite-app fixture"

echo "3. Applying review-required file patch..."
git apply "$PATCH"

echo "4. Running clarion check..."
echo ""

# Run clarion check and capture result
set +e
CHECK_OUTPUT=$("$CLARION" check --repo "$WORK" --json 2>&1)
EXIT_CODE=$?
set -e

echo "   Exit code: $EXIT_CODE"
echo ""

# --- Interpret result ---
# For review-required files, Clarion may return:
# - requires_contract (no contract covers this change — human review needed)
# - pass (if a valid contract exists)
# Any non-pass result demonstrates the governance surface.

if [ "$EXIT_CODE" -eq 0 ]; then
  echo "5. Verdict: PASS"
  echo "   The change was covered by an existing contract or policy."
  echo "   This is valid — review-required does not always block."
else
  echo "5. Verdict: NON-PASS (governance surface active)"
  echo "   Clarion flagged the review-required file change."
fi
echo ""

if ! printf '%s' "$CHECK_OUTPUT" | grep -q '"schema_version"'; then
  echo "WARNING: clarion check did not emit a JSON CLI envelope."
  echo "   The demo still ran, but structured output was not available."
  echo ""
fi

# --- Generate report ---
mkdir -p "$ARTIFACTS_DIR"
printf '%s\n' "$CHECK_OUTPUT" > "$RESULT_JSON"

# Extract verdict if available
VERDICT="unknown"
if printf '%s' "$CHECK_OUTPUT" | grep -q '"verdict"'; then
  VERDICT=$(printf '%s' "$CHECK_OUTPUT" | grep -o '"verdict": *"[^"]*"' | head -1 | sed 's/.*: *"//;s/"//')
fi

cat > "$ARTIFACTS_DIR/review-required-report.md" << EOF
# Review-Required Report

Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

## Result

**Verdict: ${VERDICT}**

The review-required file \`src/llm_adapter.py\` was modified. Clarion evaluated
the change and produced a governance result.

## Details

- Fixture: \`fixtures/trust-bite-app/\`
- Patch: \`scenarios/review-required/patches/review-required-adapter-change.patch\`
- Exit code: $EXIT_CODE
- Triggered file: \`src/llm_adapter.py\`
- Governance surface: review-required
- Machine-readable envelope: \`artifacts/review-required/result.json\`

## What this demonstrates

Unlike protected files (which always produce a non-pass), review-required files
surface a governance state that informs the workflow. The change is not necessarily
blocked, but Clarion ensures a human is aware before it merges.

This is the difference between:
- **Protected**: change is blocked without a contract
- **Review-required**: change is flagged for human attention

## Source of authority

This result comes from Clarion CLI output, not from agent self-report.

- Command: \`pantheon check\`
- Envelope schema: \`pantheon_cli_result@0.1.0\`
- Verdict: \`${VERDICT}\`
- Disclosure: \`full-local\`
EOF

echo "6. Report written to: artifacts/review-required/review-required-report.md"
echo "7. JSON written to: artifacts/review-required/result.json"
echo ""
echo "=== Demo complete ==="
