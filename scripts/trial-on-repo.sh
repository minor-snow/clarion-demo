#!/usr/bin/env bash
set -euo pipefail

# trial-on-repo.sh — Run clarion trial on a user's repository
#
# Usage:
#   ./scripts/trial-on-repo.sh /path/to/repo [--bug-title "title"]

CLARION="${CLARION_BIN:-clarion}"

# --- Parse arguments ---
REPO_PATH=""
BUG_TITLE=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --bug-title)
      BUG_TITLE="$2"
      shift 2
      ;;
    -*)
      echo "Unknown option: $1" >&2
      exit 2
      ;;
    *)
      REPO_PATH="$1"
      shift
      ;;
  esac
done

# --- Validate ---
if [ -z "$REPO_PATH" ]; then
  echo "Usage: $0 /path/to/repo [--bug-title \"title\"]" >&2
  echo "" >&2
  echo "Runs clarion trial against the specified repository." >&2
  echo "Generates .clarion-trial/clarion_trial_report.md in the target repo." >&2
  exit 2
fi

if [ ! -d "$REPO_PATH" ]; then
  echo "Error: '$REPO_PATH' is not a directory" >&2
  exit 2
fi

if [ ! -d "$REPO_PATH/.git" ]; then
  echo "Error: '$REPO_PATH' is not a git repository (no .git directory)" >&2
  exit 2
fi

echo "=== Clarion Trial ==="
echo "Target: $REPO_PATH"
echo ""

# --- Step 1: Doctor ---
echo "1. Running trial doctor..."
"$CLARION" trial doctor --repo "$REPO_PATH"
echo "   Done."
echo ""

# --- Step 2: Scan ---
echo "2. Running trial scan..."
"$CLARION" trial scan --repo "$REPO_PATH"
echo "   Done."
echo ""

# --- Step 3: PR ---
echo "3. Running trial pr..."
"$CLARION" trial pr --repo "$REPO_PATH"
echo "   Done."
echo ""

# --- Step 4: Report ---
echo "4. Running trial report..."
"$CLARION" trial report --repo "$REPO_PATH"
echo "   Done."
echo ""

# --- Step 5: Bug (optional) ---
if [ -n "$BUG_TITLE" ]; then
  echo "5. Running trial bug..."
  "$CLARION" trial bug --repo "$REPO_PATH" --title "$BUG_TITLE"
  echo "   Done."
  echo ""
fi

# --- Output ---
REPORT_PATH="$REPO_PATH/.clarion-trial/clarion_trial_report.md"

if [ -f "$REPORT_PATH" ]; then
  echo "=== Trial complete ==="
  echo "Report: $REPORT_PATH"
else
  echo "=== Trial complete ==="
  echo "Warning: Expected report not found at $REPORT_PATH"
  echo "Check the output above for errors."
fi
