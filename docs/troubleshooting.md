# Troubleshooting

## Common issues

### `clarion: command not found`

The Clarion binary is not on your PATH.

**Fix:** Either add the binary to PATH or set the `CLARION_BIN` environment variable:

```bash
export CLARION_BIN=/path/to/clarion
./scripts/demo-bite.sh
```

### `Error: not a git repository`

The target path does not contain a `.git` directory.

**Fix:** Ensure you're pointing to a git repository root:

```bash
./scripts/trial-on-repo.sh /path/to/repo  # must have .git/
```

### `Error: no commits found`

The repository has no commits.

**Fix:** Make at least one commit before running trial:

```bash
cd /path/to/repo
git add -A && git commit -m "Initial commit"
```

### Demo produces `pass` instead of `fail`

This should not happen with the provided fixture and patch. If it does:

1. Ensure you're using the correct Clarion binary version
2. Run `./scripts/reset-fixture.sh` and try again
3. Check that `fixtures/trust-bite-app/pantheon.json` has not been modified

### Trial report is empty or missing

Possible causes:
- The repository has very few files
- The repository has no git history
- An error occurred during scan (check stderr output)

### Scripts fail on Windows

The scripts require bash. On Windows, use:
- Git Bash
- WSL (Windows Subsystem for Linux)
- Any POSIX-compatible shell

### Permission denied on scripts

Make scripts executable:

```bash
chmod +x scripts/*.sh
```

## Getting help

If you encounter an issue not listed here, check:
1. The Clarion binary version (`clarion --version`)
2. The error output (stderr)
3. The exit code
