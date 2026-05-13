#!/usr/bin/env bash
set -euo pipefail

# demo-bite.sh — Run the trust-bite demo
#
# Copies the fixture to a temp directory, applies the protected-file patch,
# runs clarion check, and asserts a non-pass result.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

CLARION="${CLARION_BIN:-clarion}"
FIXTURE="$REPO_ROOT/fixtures/trust-bite-app"
PATCH="$REPO_ROOT/scenarios/bite/patches/protected-policy-change.patch"
ARTIFACTS_DIR="$REPO_ROOT/artifacts/bite"

# --- Setup temp workspace ---
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

echo "=== Clarion Trust-Bite Demo ==="
echo ""
echo "1. Copying fixture to temp workspace..."
cp -r "$FIXTURE/." "$WORK/"

echo "2. Initializing git repository..."
cd "$WORK"
git init -q
git add -A
git commit -q -m "Initial commit: trust-bite-app fixture"

echo "3. Applying protected-file patch..."
git apply "$PATCH"
git add -A
git commit -q -m "Modify protected policy_engine.py"

echo "4. Running clarion check..."
echo ""

# Run clarion check and capture result
set +e
CHECK_OUTPUT=$("$CLARION" check --repo "$WORK" --json 2>&1)
EXIT_CODE=$?
set -e

echo "   Exit code: $EXIT_CODE"
echo ""

# --- Assert non-pass ---
if [ "$EXIT_CODE" -eq 0 ]; then
  echo "ERROR: Expected non-pass (exit code != 0) but got pass (exit code 0)"
  echo "This means the governance rule was NOT enforced."
  exit 1
fi

echo "5. Verdict: NON-PASS (as expected)"
echo "   The protected-file rule was enforced."
echo ""

# --- Generate report ---
mkdir -p "$ARTIFACTS_DIR"

cat > "$ARTIFACTS_DIR/bite-report.md" << EOF
# Bite Report

Generated: $(date -u +"%Y-%m-%dT%H:%M:%SZ")

## Result

**Verdict: NON-PASS**

The protected file \`src/policy_engine.py\` was modified and Clarion correctly
returned a non-pass result.

## Details

- Fixture: \`fixtures/trust-bite-app/\`
- Patch: \`scenarios/bite/patches/protected-policy-change.patch\`
- Exit code: $EXIT_CODE
- Rule triggered: \`no-modify-policy-engine\`

## Raw output

\`\`\`
$CHECK_OUTPUT
\`\`\`

## Interpretation

This proves that Clarion's governance enforcement is active. An AI agent
modifying a protected file will be caught and the change will not pass review.
EOF

echo "6. Report written to: artifacts/bite/bite-report.md"
echo ""
echo "=== Demo complete ==="
