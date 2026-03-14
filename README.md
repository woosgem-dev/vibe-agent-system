# Vibe-Agent-System (VAS)

**VAS** is a prompt engineering framework that introduces **OOP-style inheritance** into LLM agent definitions. It allows you to build complex, specialized agents by composing reusable interfaces, classes, and traits.

## Key Features

- **3-Tier Hierarchy**: Organize agents into `Interface` (Philosophy), `Class` (Domain), and `Instance` (Project) levels.
- **Meta-Manual Interface**: Base interfaces act as structural guidelines, forcing descendants to define specific identities and rules.
- **Multi-Parent Inheritance**: Compose agents using multiple traits (e.g., `TypeScript` + `Senior` + `Security_Expert`).
- **Key-based Replacement**: Rules are merged and overridden using unique identifiers like `[Key]` or `**Key**:`, preventing prompt bloat while maintaining precision.
- **Auto-Activation**: Seamless integration with the Gemini CLI via environment variables.

## Project Structure

```text
/vibe-agent-system
├── hooks/
│   └── hooks.json           # Session-start auto-activation hook
├── skills/
│   └── vas-activate/
│       ├── SKILL.md         # Core activation and merge logic
│       ├── examples/        # Standard usage examples
│       └── references/      # Detailed protocol specifications
└── README.md
```

## Getting Started

### 1. Define an Agent
Create a Markdown file with YAML frontmatter. Refer to `skills/vas-activate/examples/` for templates. Use **$VAS_PLUGIN_PATH** to inherit from core interfaces regardless of installation location.

```markdown
---
type: instance
name: my_local_agent
extends:
  - $VAS_PLUGIN_PATH/skills/vas-activate/examples/abstract_agent.md
  - ./path/to/my_custom_class.md
---

## Persona
- [Identity] You are a Senior TS Engineer focused on high-performance architecture.
```

## Must
- [Priority] All implementation must use Strict Mode TypeScript.
```

### 2. Activate via Environment Variable
Set the `VAS_AGENT_PATH` to your agent's file path before starting a session.

```bash
export VAS_AGENT_PATH="/path/to/my_dev_agent.md"
```

## Inheritance Logic

- **Between Parents**: Rules with the same Key from multiple parents are **accumulated** (combined).
- **Instance vs Parents**: A rule defined in the Instance **replaces** all inherited rules with the same Key.
- **Persona**: The Instance Persona completely replaces all inherited Personas to maintain a singular identity.

## Documentation

For more details, see:
- [File Format Specification](./skills/vas-activate/references/file-format.md)
- [Inheritance Protocol](./skills/vas-activate/references/inheritance-protocol.md)
- [Testing & Validation Protocol](./skills/vas-activate/references/testing-protocol.md)

## License

MIT
