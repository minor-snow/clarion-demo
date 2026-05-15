# Example: How governance shaped a real AI-assisted implementation

This is an example from one trial project. Your project will produce different
governance effects depending on its technology stack, architecture, and declared
governance rules.

## Project context

- Stack: React + TypeScript + Zustand + ComfyUI integration
- AI assistant: used for feature implementation with governance active
- Governance config: pantheon.json with protected core, review-required adapters

## Observed governance effects

### Behavior shaping (before violations)

These rules guided the AI assistant's choices without producing a Clarion verdict:

| Rule | Effect on AI behavior |
|------|----------------------|
| Local-only network binding | AI used `localhost` endpoints, did not introduce external calls without prompting |
| Prefer Zustand over Redux | AI chose Zustand for new state management without being told |
| Use Semi Design components | AI imported from `@douyinfe/semi-ui` instead of introducing new UI libraries |
| FSM for workflow state | AI structured complex flows as finite state machines |
| Axios for HTTP | AI used Axios consistently, did not introduce fetch or other HTTP clients |

### Machine enforcement (Clarion verdicts)

These rules produced concrete Clarion results when the AI attempted changes:

| Trigger | Clarion verdict | Outcome |
|---------|----------------|---------|
| Modified protected policy engine | `requires_contract` | Change blocked until contract created |
| Modified review-required adapter | `requires_contract` | Change flagged for human review |
| New file in protected directory | non-pass | AI informed, restructured to avoid protected path |

### Artifact safety (post-processing)

| Check | Result |
|-------|--------|
| No absolute paths in reports | pass |
| No raw diff hunks in shared docs | pass |
| No secret-like tokens | pass |

## Key insight

The AI did not need to be told about most rules explicitly in every prompt.
The governance configuration shaped behavior passively (through AGENTS.md) and
actively (through Clarion check results). The combination meant:

1. Most changes followed project conventions automatically (behavior shaping)
2. Risky changes were caught before merge (machine enforcement)
3. Shared artifacts stayed clean (artifact safety)

## Limitations of this example

- This is one project with one technology stack
- Behavior shaping effectiveness depends on the AI model and context window
- Not all rules had machine enforcement — some were advisory only
- The project had an experienced human reviewer who could validate AI choices

## What this means for your project

Your governance effects will differ. Run `clarion trial` on your repository to
see which governance surfaces are available and what enforcement is possible
today:

```bash
./scripts/trial-on-repo.sh /path/to/your/repo
```
