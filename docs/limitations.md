# Limitations

## Demo limitations

1. **Single trust-bite path** — The demo only exercises one protected policy-file scenario. Clarion supports additional rule types and workflows not shown here.

2. **Minimal fixture** — The fixture is a small Python app. Real repositories are larger and more complex.

3. **No multi-rule interaction** — The demo does not show how multiple rules interact or compose.

4. **No CI integration demo** — The demo runs locally. CI integration is documented but not demonstrated end-to-end.

5. **No agent interaction** — The demo applies a patch manually. It does not show an actual AI agent being governed in real-time.

## Trial limitations

1. **Heuristic recommendations** — Trial's rule suggestions are heuristic-based. They require human review before adoption.

2. **Git history dependent** — Trial analyzes git history. Repos with limited history produce less useful reports.

3. **Language agnostic** — Trial does not perform language-specific analysis. It works at the file/path level.

4. **Point-in-time snapshot** — Trial evaluates the repo as it exists now. It does not predict future changes.

## Platform limitations

1. **Bash required** — Scripts require bash. Windows users need Git Bash or WSL.

2. **Git required** — The demo and trial both require git.

3. **Binary distribution** — Clarion is distributed as a binary. Source is not available.
