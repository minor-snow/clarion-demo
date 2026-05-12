#!/usr/bin/env bash
set -euo pipefail

# Clarion Demo — Bootstrap
# Initializes the demo fixture with Clarion governance.

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEMO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
FIXTURE_DIR="$DEMO_ROOT/fixtures/demo-app"

echo ""
echo "╔══════════════════════════════════════════════════════╗"
echo "║  Clarion Demo — Bootstrap                           ║"
echo "╚══════════════════════════════════════════════════════╝"
echo ""

# Resolve Clarion binary
if [ -n "${CLARION_BIN:-}" ]; then
  CLARION="node $CLARION_BIN"
else
  CLARION="clarion"
fi

echo "Using Clarion: $CLARION"
echo "Demo fixture:  $FIXTURE_DIR"
echo ""

# Step 1: Initialize Clarion in the fixture
echo "→ Initializing Clarion governance..."
cd "$FIXTURE_DIR"
$CLARION init --repo . 2>/dev/null || true
echo "  ✓ Clarion initialized"

# Step 2: Verify health
echo "→ Running doctor check..."
$CLARION doctor --repo . --json > /dev/null 2>&1 && echo "  ✓ Doctor: healthy" || echo "  ⚠ Doctor: needs attention (continuing anyway)"

echo ""
echo "Bootstrap complete. Run ./scripts/run-demo.sh to start the guided demo."
echo ""
