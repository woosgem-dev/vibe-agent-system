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

## Installation

### Via Marketplace (Recommended)
Search for **Vibe-Agent-System** in your agent's extension marketplace and click install.

### Manual Installation (Local/Dev)
To use VAS without a marketplace or to develop your own traits, link the repository to your agent's extension directory.

#### 1. Clone the repository
```bash
git clone git@github.com:woosgem-dev/vibe-agent-system.git
cd vibe-agent-system
```

#### 2. Cross-Agent Compatibility (Symlink - Recommended)

To ensure different agents (Claude, Gemini, Codex) recognize this plugin correctly, create the following symbolic links in their respective extension directories:

**For Gemini / Codex (Precision Linking)**
Gemini expects the `gemini-extension.json` at the root. Link it to our single `plugin.json` manifest:
```bash
# Create the target extension directory
mkdir -p ~/.gemini/extensions/vibe-agent-system

# Link the manifest (using plugin.json as the source)
ln -s $(pwd)/plugin.json ~/.gemini/extensions/vibe-agent-system/gemini-extension.json

# Link hooks and skills directories
ln -s $(pwd)/hooks ~/.gemini/extensions/vibe-agent-system/hooks
ln -s $(pwd)/skills ~/.gemini/extensions/vibe-agent-system/skills
```

**For Claude Desktop (Precision Linking)**
Claude Desktop expects a specific structure (`.claude-plugin` subfolder):
```bash
# Create the target plugin directory
mkdir -p ~/.claude/plugins/vibe-agent-system/.claude-plugin

# Link the manifest
ln -s $(pwd)/plugin.json ~/.claude/plugins/vibe-agent-system/.claude-plugin/plugin.json

# Link hooks and skills directories
ln -s $(pwd)/hooks ~/.claude/plugins/vibe-agent-system/hooks
ln -s $(pwd)/skills ~/.claude/plugins/vibe-agent-system/skills
```

#### Alternative: Register via CLI
If you prefer not to use symlinks, you can register the local path directly:
```bash
gemini extensions add $(pwd)
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
