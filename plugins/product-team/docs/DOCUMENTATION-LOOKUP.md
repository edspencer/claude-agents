# Documentation Lookup Pattern

This document explains how agents in this plugin should reference documentation files.

NOTE: There is an issue with ${CLAUDE_PLUGIN_ROOT} that prevents the plugin from working correctly. See https://github.com/anthropics/claude-code/issues/9354 for details.

## Layered Documentation System

The plugin uses a **layered configuration** approach where plugin defaults can be overridden by project-specific customizations:

### Layer 1: Plugin Defaults (Global)
- Location: `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/`
- Provides: Base process rules and standards that work across projects
- When to use: Always check first for core processes

### Layer 2: Project Overrides (Local)
- Location: `.claude/docs/` (in the project directory)
- Provides: Project-specific extensions, modifications, or overrides
- When to use: Check after plugin docs to see if project has customizations

## Lookup Order for Agents

When an agent needs to reference process documentation, follow this order:

1. **Check project overrides first**: `.claude/docs/[document-name].md`
2. **Fall back to plugin defaults**: `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/[document-name].md`

If a project-specific version exists, it should be treated as **extensions or overrides** to the base plugin rules. Apply both sets of rules, with project rules taking precedence on conflicts.

## Core Documentation Files

### Standing Orders
- Plugin: `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/standing-orders.md`
- Project: `.claude/docs/standing-orders.md`
- Purpose: Cross-cutting concerns that apply to all agents

### Team Structure
- Plugin: `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/team.md`
- Project: `.claude/docs/team.md`
- Purpose: Agent roles and responsibilities

### Process Documentation
All in `docs/processes/` subdirectory:
- `spec-rules.md` - Specification writing process
- `plan-rules.md` - Implementation planning process
- `code-rules.md` - Code implementation process
- `agent-rules.md` - Agent creation process
- `process-manager-rules.md` - Process management rules

## Standard Section for All Agents

Every agent should include this section after the frontmatter:

```markdown
## Documentation Lookup

**IMPORTANT: This plugin uses layered documentation.**

Before beginning work, check these documents in order:
1. **Standing Orders**: Check `.claude/docs/standing-orders.md` (project) OR `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/standing-orders.md` (plugin)
2. **Process Rules**: Check `.claude/docs/processes/[relevant-process].md` (project) OR `~/.claude/plugins/marketplaces/edspencer-agents/plugins/product-team/docs/processes/[relevant-process].md` (plugin)

If both project and plugin versions exist, use the project version as it contains project-specific extensions or overrides.
```

## Future Migration Note

When the `${CLAUDE_PLUGIN_ROOT}` variable bug is fixed (see https://github.com/anthropics/claude-code/issues/9354), we will update all references to:

- `${CLAUDE_PLUGIN_ROOT}/docs/standing-orders.md`
- `${CLAUDE_PLUGIN_ROOT}/docs/processes/[document].md`

This will make the plugin more portable and easier to maintain.
