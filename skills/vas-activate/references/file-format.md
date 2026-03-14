# VAS File Format Specification

## Structure

Every VAS agent definition file consists of two parts:

1. **YAML Frontmatter** — metadata enclosed in `---` delimiters
2. **Markdown Body** — rules and constraints as headed sections

```markdown
---
(frontmatter)
---

(body)
```

## Frontmatter Fields

### All Types

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `type` | string | Yes | One of: `interface`, `class`, `instance` |
| `name` | string | Yes | Unique identifier for this agent |

### Class and Instance Only

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `extends` | string | Yes | Explicit file path (absolute or relative) to parent agent |
| `skills` | list of strings | No | File paths to skill definition files |

### Instance Only (Optional)

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `override` | list of strings | No | Short override directives (alternative to body Override section) |

Note: `override` can appear in frontmatter as a short list OR in body as a detailed `## Override` section. If both exist, body section takes precedence.

## Body Sections

### `## Persona`

Defines the agent's core identity, tone, and foundational mindset. This section sets the stage for how all other rules are interpreted.

```markdown
## Persona
- You are a senior software architect with a focus on high-scale distributed systems.
- You prioritize clarity and performance in every technical decision.
```

### `## Must`

Mandatory constraints. Merged via **Key-based Replacement**.

### `## Never`

Absolute prohibitions. Merged via **Key-based Replacement**.

### `## Should`

Strong recommendations. Merged via **Key-based Replacement**.

### Rule Keys

For all sections (Must, Never, Should, Override), a rule is matched by its **Key** for inheritance resolution.

- **Bracketed keys:** `[Key] Rule content`
- **Bold keys:** `**Key:** Rule content`

If a child level defines the same Key, the child's rule replaces the parent's rule. This allows an Interface to provide a "Meta-Manual" by defining keys with placeholder guidelines.

### `## Override`

Project-specific rules that take precedence over inherited rules. Each override uses a bold key label.

```markdown
## Override
- **Priority:** Data accuracy > Loading speed
- **Validation:** Enforce Zod runtime schema validation on all I/O
- **Monitoring:** Send Sentry Critical event on payment failure
```

Override keys (the bold label) are used for conflict resolution. Same key in child replaces parent.

## Type-Specific Constraints

### Interface (`type: interface`)

- Must NOT have `extends` field
- Must NOT have `skills` field (interfaces define philosophy, not methods)
- Must NOT have `## Override` section
- Should define foundational `## Must` and `## Never` rules

### Class (`type: class`)

- Must have `extends` pointing to an Interface or another Class
- May have `skills`
- May have `## Override` to adjust inherited rules
- May add `## Must`, `## Never`, `## Should` rules

### Instance (`type: instance`)

- Must have `extends` pointing to a Class or Interface
- May have `skills`
- May have `## Override` to set project-specific directives
- May add `## Must`, `## Never`, `## Should` rules

## Path Resolution

All paths in `extends` and `skills` are explicit file paths.

- **Absolute paths**: `/Users/team/shared-agents/abstract_agent.md`
- **Relative paths**: `./agents/backend_agent.md` (relative to the referencing file's location)
- **Environment variables**: Paths may reference environment variables set in project config

No name-based resolution. No implicit directory scanning. Every reference must be a valid, readable file path.
