#!/usr/bin/env bash
set -euo pipefail

# reset-fixture.sh — Reset the trust-bite fixture to clean state
#
# Removes any runtime artifacts and restores the fixture directory.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"

echo "Resetting fixture to clean state..."

# Remove generated artifacts
rm -rf "$REPO_ROOT/artifacts/bite"
mkdir -p "$REPO_ROOT/artifacts"
touch "$REPO_ROOT/artifacts/.gitkeep"

# Remove any .clarion-trial directories that may have been created
rm -rf "$REPO_ROOT/fixtures/trust-bite-app/.clarion-trial"

# Remove any temp files in fixture
rm -rf "$REPO_ROOT/fixtures/trust-bite-app/.tmp"

echo "Done. Fixture is clean."
