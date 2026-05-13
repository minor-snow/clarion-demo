#!/usr/bin/env bash
set -euo pipefail

# assert-no-runtime-state.sh — Assert no committed runtime artifacts
#
# Checks that no runtime-generated files have been committed to the repository.
# Used in CI to ensure the repo stays clean.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

ERRORS=0

echo "Checking for committed runtime artifacts..."

# Check for .clarion-trial directories
if git -C "$REPO_ROOT" ls-files --error-unmatch '.clarion-trial' 2>/dev/null; then
  echo "ERROR: .clarion-trial/ is committed to the repository"
  ERRORS=$((ERRORS + 1))
fi

# Check for artifacts (except .gitkeep)
ARTIFACT_FILES=$(git -C "$REPO_ROOT" ls-files 'artifacts/' 2>/dev/null | grep -v '.gitkeep' || true)
if [ -n "$ARTIFACT_FILES" ]; then
  echo "ERROR: Runtime artifacts are committed:"
  echo "$ARTIFACT_FILES"
  ERRORS=$((ERRORS + 1))
fi

# Check for .tmp directories
if git -C "$REPO_ROOT" ls-files --error-unmatch '.tmp' 2>/dev/null; then
  echo "ERROR: .tmp/ is committed to the repository"
  ERRORS=$((ERRORS + 1))
fi

# Check for node_modules
if git -C "$REPO_ROOT" ls-files --error-unmatch 'node_modules' 2>/dev/null; then
  echo "ERROR: node_modules/ is committed to the repository"
  ERRORS=$((ERRORS + 1))
fi

if [ "$ERRORS" -gt 0 ]; then
  echo ""
  echo "FAIL: $ERRORS runtime artifact(s) found in committed files."
  exit 1
fi

echo "PASS: No runtime artifacts committed."
