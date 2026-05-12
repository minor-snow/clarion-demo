#!/usr/bin/env bash
set -euo pipefail

# Clarion Demo — Reset
# Removes all .pantheon/ state and returns the demo to a clean starting point.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEMO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FIXTURE_DIR="$DEMO_ROOT/fixtures/demo-app"

echo "Resetting demo state..."

if [ -d "$FIXTURE_DIR/.pantheon" ]; then
  rm -rf "$FIXTURE_DIR/.pantheon"
  echo "  ✓ Removed .pantheon/ state"
else
  echo "  (no state to remove)"
fi

echo "Done. Run ./scripts/bootstrap.sh to start fresh."
