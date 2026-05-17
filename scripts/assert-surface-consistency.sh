#!/usr/bin/env bash
set -euo pipefail

# assert-surface-consistency.sh — Prevent drift regression
#
# Checks that all public-facing docs and scripts use consistent paths,
# verdicts, and terminology. Run in CI to catch drift before it ships.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ERRORS=0

fail() {
  echo "FAIL: $1"
  ERRORS=$((ERRORS + 1))
}

pass() {
  echo "PASS: $1"
}

echo "=== Surface Consistency Check ==="
echo ""

# --- 1. No old flat canonical report path ---
echo "1. Checking for stale canonical report path..."
OLD_PATH_PATTERN='clarion-trial/clarion_trial_report'
EXCLUDE_DIRS=".git|artifacts|.clarion-trial|node_modules"

STALE_REFS=$(grep -r "$OLD_PATH_PATTERN" "$REPO_ROOT" \
  --include="*.md" --include="*.sh" --include="*.yml" --include="*.yaml" \
  -l 2>/dev/null | grep -vE "$EXCLUDE_DIRS|assert-surface-consistency" || true)

if [ -n "$STALE_REFS" ]; then
  fail "Old flat canonical report path found in:"
  echo "$STALE_REFS" | sed 's/^/   /'
  echo "   Should be: .clarion-trial/report/clarion_trial_report.md"
else
  pass "No stale canonical report paths"
fi
echo ""

# --- 2. Bridge report path consistency ---
echo "2. Checking bridge report path consistency..."
WRONG_BRIDGE=$(grep -r "clarion-trial/report/bridge_report" "$REPO_ROOT" \
  --include="*.md" --include="*.sh" --include="*.yml" \
  -l 2>/dev/null | grep -vE "$EXCLUDE_DIRS|assert-surface-consistency" || true)

if [ -n "$WRONG_BRIDGE" ]; then
  fail "Bridge report in wrong directory (should be .clarion-trial/bridge_report.md, not in report/):"
  echo "$WRONG_BRIDGE" | sed 's/^/   /'
else
  pass "Bridge report path consistent"
fi
echo ""

# --- 3. No requires_review in public docs (actual verdict is requires_contract) ---
echo "3. Checking for incorrect verdict terminology..."
WRONG_VERDICT=$(grep -rn "requires_review" "$REPO_ROOT" \
  --include="*.md" --include="*.sh" --include="*.yml" --include="*.yaml" --include="*.json" \
  2>/dev/null | grep -vE "$EXCLUDE_DIRS|assert-surface-consistency" || true)

if [ -n "$WRONG_VERDICT" ]; then
  fail "Found 'requires_review' — actual CLI verdict is 'requires_contract':"
  echo "$WRONG_VERDICT" | sed 's/^/   /'
else
  pass "No incorrect verdict terminology"
fi
echo ""

# --- 4. No internal phase references ---
echo "4. Checking for internal phase/milestone references..."
INTERNAL_REFS=$(grep -rn '\bP2[0-9]\b\|Phase 2[0-9]' "$REPO_ROOT" \
  --include="*.md" \
  2>/dev/null | grep -vE "$EXCLUDE_DIRS" || true)

if [ -n "$INTERNAL_REFS" ]; then
  fail "Internal phase references found in public docs:"
  echo "$INTERNAL_REFS" | sed 's/^/   /'
else
  pass "No internal phase references"
fi
echo ""

# --- 5. No old demo concepts ---
echo "5. Checking for old demo concepts (workgraph, bootstrap.sh, run-demo.sh)..."
OLD_CONCEPTS=$(grep -rn 'bootstrap\.sh\|run-demo\.sh\|workgraph\|observe.*route.*transcript' "$REPO_ROOT" \
  --include="*.md" --include="*.sh" \
  2>/dev/null | grep -vE "$EXCLUDE_DIRS|assert-surface-consistency" || true)

if [ -n "$OLD_CONCEPTS" ]; then
  fail "Old demo concepts found:"
  echo "$OLD_CONCEPTS" | sed 's/^/   /'
else
  pass "No old demo concepts"
fi
echo ""

# --- 6. pantheon.json and pantheon.alpha.json must be identical ---
echo "6. Checking fixture config mirror consistency..."
P_JSON="$REPO_ROOT/fixtures/trust-bite-app/pantheon.json"
P_ALPHA="$REPO_ROOT/fixtures/trust-bite-app/pantheon.alpha.json"

if [ -f "$P_JSON" ] && [ -f "$P_ALPHA" ]; then
  if cmp -s "$P_JSON" "$P_ALPHA"; then
    pass "pantheon.json and pantheon.alpha.json are byte-identical"
  else
    fail "pantheon.json and pantheon.alpha.json have diverged"
  fi
else
  fail "One or both fixture config files missing"
fi
echo ""

# --- Summary ---
echo "=== Summary ==="
if [ "$ERRORS" -eq 0 ]; then
  echo "All surface consistency checks passed."
  exit 0
else
  echo "$ERRORS check(s) failed."
  exit 1
fi
