# VAS Inheritance Protocol

## Chain Resolution Procedure

Given an agent file, resolve its full inheritance chain:

```
Step 1: Read the agent file
Step 2: Parse frontmatter → extract `extends` path
Step 3: If `extends` exists → read the parent file, go to Step 2
Step 4: If no `extends` (Interface reached) → stop
Step 5: Merge rules from Interface → Class → Instance (bottom-up priority)
```

### Example Chain

```
Instance: payment_architect.md
  └─ extends: /agents/backend_agent.md (Class)
       └─ extends: /agents/abstract_agent.md (Interface)
            └─ no extends → root of chain
```

Resolution order: Read abstract_agent → merge backend_agent → merge payment_architect

## Merge Strategies

### Section Replacement (Persona)

The child's entire section completely replaces the parent's section.

### Key-based Replacement (Must, Never, Should, Override)

Rules are merged based on their **Key identifier**. If a child defines a rule with the same key as the parent, the child's rule **replaces** the parent's rule. If the key is unique, it is added to the merged set.

**Key identification:**
- Labels in brackets: `[Priority]`
- Bold labels followed by a colon: `**Priority:**`

```
Interface Must:                        Class Must:
- [Priority] Base principle guideline  - [Priority] All APIs must be versioned
- [Safety] Security guideline          - [Performance] Fast responses

Merged Must:
- [Priority] All APIs must be versioned (Replaced)
- [Safety] Security guideline (Inherited)
- [Performance] Fast responses (Added)
```

This strategy allows the Interface to act as a "Meta-Manual" or "Template" that descendants fill in or override.

### Override Section Priority

Override rules from child levels replace conflicting parent rules on the same topic.

```
Interface (no override)
  ↓
Class Override:
  - Priority: Observability > Dev speed
  ↓
Instance Override:
  - Priority: Data accuracy > Loading speed    ← replaces Class Priority
  - Validation: Zod runtime enforcement        ← new, no conflict
```

Match overrides by their key (the bold label before the colon). Same key = replacement. New key = addition.

## Conflict Resolution Rules

| Scenario | Resolution |
|----------|-----------|
| Child Must contradicts Parent Must | Both apply (accumulate). If truly incompatible, child Override resolves it |
| Child Override contradicts Parent Must | Override wins — project-specific needs take precedence |
| Child Override contradicts Parent Never | Override wins — but log a warning that a Never rule is being overridden |
| Same Override key at multiple levels | Closest descendant wins (Instance > Class) |
| Missing `extends` file | Stop and report. Do not guess or skip |
| Circular `extends` reference | Stop and report. Do not attempt resolution |

## Skills Merge

Skills from all levels combine into a flat list. No deduplication needed — if the same skill appears at multiple levels, it is still treated as one available method.

```
Interface: (no skills)
Class skills: [api_design, database_patterns]
Instance skills: [payment_security]

Merged skills: [api_design, database_patterns, payment_security]
```

## Edge Cases

### Single-Level Agent (Interface Only)

An agent file with `type: interface` and no `extends` is self-contained. Apply its rules directly with no merge needed.

### Skipping Levels

An Instance can directly extend an Interface (skipping Class). The 3-tier hierarchy is a convention, not a constraint.

```yaml
---
type: instance
name: simple_agent
extends: /path/to/abstract_agent.md   # directly extends Interface
---
```

### Deep Chains

Chains deeper than 3 levels are valid. Resolution follows the same procedure regardless of depth.

```
Interface → Class A → Class B → Instance
```

All levels merge in order: Interface → Class A → Class B → Instance.
