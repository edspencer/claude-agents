# Claude Agents

A collection of Claude Code plugins that provide specialized agent teams for different aspects of software development.

## Overview

This repository contains multiple Claude Code plugins, each representing a specialized team of agents for different workflows. Each plugin is self-contained with its own agents, commands, skills, and documentation.

## Available Plugins

### Product Team
**Version:** 0.1.0
**Category:** Development

A comprehensive product development workflow plugin featuring:
- 12 specialized agents (spec-writer, plan-writer, code-writer, etc.)
- 17 slash commands for quick workflows
- GitHub issue synchronization skill
- Structured processes for spec → plan → implement → test
- Layered configuration system (plugin defaults + project overrides)

[See full documentation →](plugins/product-team/README.md)

## Installation

### Add the Marketplace

```bash
/plugin marketplace add edspencer/claude-agents
```

### Install Individual Plugins

```bash
# Install the Product Team plugin
/plugin install product-team@edspencer-agents
```

## Plugin Structure

Each plugin in this repository follows the standard Claude Code plugin structure:

```
plugins/
└── plugin-name/
    ├── .claude-plugin/
    │   ├── plugin.json         # Plugin metadata
    │   └── marketplace.json    # Plugin can be a marketplace itself
    ├── agents/                 # Specialized agents
    ├── commands/               # Slash commands
    ├── skills/                 # Reusable skills
    ├── docs/                   # Process documentation
    └── README.md              # Plugin documentation
```

## Adding New Plugins

Future plugins will be added to the `plugins/` directory:

- `plugins/data-team/` - Data engineering and analytics workflows
- `plugins/design-team/` - Design system and UI/UX workflows
- `plugins/infrastructure-team/` - DevOps and infrastructure workflows
- `plugins/qa-team/` - Quality assurance and testing workflows

Each team plugin can be installed independently based on your project needs.

## Development

### Adding a New Plugin

1. Create a new directory in `plugins/`
2. Follow the standard plugin structure
3. Add plugin entry to `.claude-plugin/marketplace.json`
4. Create comprehensive documentation

### Testing Locally

```bash
# Clone the repository
git clone https://github.com/edspencer/claude-agents.git
cd claude-agents

# Install to local Claude Code plugins directory
mkdir -p ~/.claude/plugins/repos
cp -r . ~/.claude/plugins/repos/claude-agents

# Restart Claude Code
# Then add the marketplace and install plugins
/plugin marketplace add edspencer/claude-agents
/plugin install product-team@edspencer-agents
```

## Philosophy

Each plugin represents a **specialized team** with:

- **Clear responsibilities** - Each agent has a specific role
- **Process documentation** - Established workflows and best practices
- **Layered configuration** - Plugin defaults that can be overridden per-project
- **GitHub integration** - Seamless task tracking and documentation sync

The goal is to provide opinionated, battle-tested workflows that can be adopted as-is or customized to fit your team's needs.

## Contributing

Contributions welcome! Whether it's:
- Improving existing plugins
- Adding new agents to existing plugins
- Creating new team plugins
- Enhancing process documentation

Please open an issue or PR.

## License

MIT License - see LICENSE file for details

## Author

Ed Spencer

## Related

- [Claude Code Documentation](https://code.claude.com/docs)
- [Plugin Development Guide](https://code.claude.com/docs/en/plugins)
- [Agent Skills Overview](https://code.claude.com/docs/en/skills)
