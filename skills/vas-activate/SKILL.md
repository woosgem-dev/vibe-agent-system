---
name: vas-activate
description: This skill should be used when the session starts and VAS_AGENT_PATH is set, when the user mentions "activate agent", "load agent", "VAS", "agent definition", or when agent definition files with extends/skills/override frontmatter are detected. Teaches the LLM how to read VAS agent definition files and resolve the inheritance chain.
version: 1.0.0
---

# VAS Agent Activation

Activate and interpret VAS (Vibe-Agent-System) agent definition files. VAS introduces OOP-style inheritance into prompt architecture, allowing agents to inherit philosophy, rules, and skills through a 3-tier hierarchy.

## Activation Flow

1. Read the agent definition file from `VAS_AGENT_PATH` environment variable
2. Parse the YAML frontmatter to extract `type`, `name`, `extends`, and `skills`
3. Follow the `extends` chain — if `extends` is a list, resolve each parent recursively.
4. Merge all rules using the priority order: **Override > Instance > All Parents (Accumulated) > Interface**
5. Register all `skills` entries as available methods for the session
6. Apply merged Must/Never/Should/Override rules as session-level constraints

## File Format

Every VAS agent file uses YAML frontmatter for metadata and Markdown body for rules.

**Frontmatter fields:**

| Field | Required | Description |
|-------|----------|-------------|
| `type` | Yes | `interface`, `class`, or `instance` |
| `name` | Yes | Agent identifier |
| `extends` | No (required for class/instance) | Explicit file path or list of paths to parent agent(s) |
| `skills` | No | List of file paths to skill definition files |

**Body sections:** `## Persona`, `## Must`, `## Never`, `## Should`, `## Override`

## Inheritance Resolution

When resolving the inheritance chain:

1. Start from the loaded file (Instance or Class)
2. Read its `extends` field (string or list of strings)
3. For each parent in `extends`, resolve its ancestry chain recursively.
4. Merge rules:
   - **Between Parents**: Rules with the same Key from multiple parents are **accumulated** (they all persist in the merged set).
   - **Instance vs Parents**: A rule defined in the **Instance** (or its **Override** section) **replaces** the entire collection of rules with the same Key inherited from all parents.
   - **Persona**: The Instance Persona replaces all inherited Personas.
5. Skills from all levels are combined into a single available skill set

If a referenced file path does not exist or cannot be read, report the missing path and ask the user to provide or correct it. Do not guess or skip.

## Priority

```
Override > Instance > All Parents (Accumulated) > Interface
```

Rules from multiple parents are collected together. Only the Instance or its Override section can replace this collection.

## After Activation

Once the inheritance chain is resolved and rules are merged:

- Treat merged Must rules as mandatory constraints
- Treat merged Never rules as absolute prohibitions
- Treat merged Should rules as strong recommendations
- Treat Override rules as the highest-priority directives
- Treat listed Skills as callable methods — read their content when needed

## Agent Development & Testing

When developing a new agent, follow the **"Define -> Resolve -> Test"** lifecycle:

1.  **Define**: Create the agent file with appropriate YAML frontmatter and Markdown body using `[Key]` or `**Key**:` format.
2.  **Resolve**: Explicitly resolve the inheritance chain and preview the final merged system prompt (as seen in `references/inheritance-protocol.md`).
3.  **Test**: Conduct a behavioral verification by injecting a sample prompt to ensure the merged rules (Persona, Must, Never, Should) are applied correctly.
4.  **Validate**: Refer to `references/testing-protocol.md` for the full checklist, including "Chimera Detection".

## Additional Resources

### Reference Files

For detailed protocol and format specifications:
- **`references/inheritance-protocol.md`** — Step-by-step inheritance resolution procedure, merge strategies, conflict handling
- **`references/file-format.md`** — Complete file format specification for all 3 tiers
- **`references/testing-protocol.md`** — Guidelines for validating agent definitions and simulating behavior

### Examples

Working examples in `examples/`:
- **`examples/abstract_agent.md`** — Interface tier example
- **`examples/backend_agent.md`** — Class tier example
- **`examples/payment_architect.md`** — Instance tier example
