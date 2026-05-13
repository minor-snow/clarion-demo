# Interpreting the Trial Report

The trial report is generated at `.clarion-trial/clarion_trial_report.md` in your repository. If the canonical Trial report is not available for the current repo state, the wrapper writes a fallback bridge report at the same path and keeps the raw lane logs beside it.

## Report sections

### Summary

High-level overview:
- Number of files analyzed
- Governance surface area (files that would benefit from rules)
- Adoption complexity (low / medium / high)

### Governance surface

Files and directories identified as governance-relevant:
- Configuration files
- Security-sensitive code
- Core business logic
- Infrastructure definitions

### Recommended rules

Suggested governance rules based on your repo's patterns:
- Protected files (files that change rarely and have high impact)
- Review-required paths
- Change-size thresholds

### PR patterns

Analysis of recent change patterns:
- Average PR size
- Files that frequently change together
- Hot spots (files with high change frequency)

### Adoption path

Suggested steps to adopt Clarion:
1. Start with the highest-confidence protected files
2. Add review-required rules for sensitive paths
3. Integrate `clarion check` into CI
4. Expand rules as confidence grows

## Risk levels

| Level | Meaning |
|-------|---------|
| Low | Few governance surfaces, simple adoption |
| Medium | Moderate governance surface, some configuration needed |
| High | Large governance surface, phased adoption recommended |

## What to do next

1. Review the recommended rules
2. Create a `pantheon.json` with the rules you agree with
3. Run `clarion check` locally to verify
4. Add to CI
