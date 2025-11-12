# Product Team Plugin

A comprehensive Claude Code plugin for product development featuring specification writing, planning, implementation, and testing agents with GitHub integration.

## Overview

This plugin provides a complete software development workflow system with:

- **11 Specialized Agents** for different aspects of development
- **14 Slash Commands** for quick workflows
- **1 Skill** for GitHub issue synchronization
- **Process Documentation** that ensures consistency across all work

## Features

### Specification & Planning Workflow

- **spec-writer**: Creates detailed specification documents from requirements
- **spec-checker**: Reviews and validates specifications
- **plan-writer**: Transforms specs into implementation plans
- **plan-checker**: Validates implementation plans
- **Slash Commands**: `/write-spec`, `/check-spec`, `/write-plan`, `/check-plan`

### Implementation Workflow

- **code-writer**: Implements features based on plans
- **code-checker**: Reviews code quality and adherence to patterns
- **Slash Commands**: `/write-code`, `/check-code`

### Documentation

- **documentation-manager**: Maintains technical and user documentation

### Testing & Quality Assurance

- **browser-tester**: Automated browser testing
- **Slash Commands**: `/run-integration-tests`, `/add-to-test-plan`

### Project Management

- **engineering-manager**: Oversees overall project workflows
- **process-manager**: Maintains and improves development processes
- **agent-maker**: Creates new specialized agents

### GitHub Integration

- **github-task-sync** skill: Bidirectional sync between local task files and GitHub issues
  - Create issues and task directories
  - Push SPEC.md, PLAN.md, TEST_PLAN.md, COMMIT_MESSAGE.md to GitHub
  - Pull task files from GitHub
  - Track work progress with timestamped logs

### Agentic Workflows

Orchestrate multiple agents for complete workflows:

- `/agentic-spec-and-plan`: Create spec and plan automatically
- `/agentic-create-spec`: Automated spec creation
- `/agentic-create-plan`: Automated plan creation
- `/agentic-implement-plan`: Automated implementation

## Installation

### From Marketplace (Coming Soon)

```bash
/plugin install product-team@your-marketplace
```

### Manual Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/edspencer/claude-agents.git
   cd claude-agents
   ```

2. Install to Claude Code plugins directory:
   ```bash
   mkdir -p ~/.claude/plugins/repos
   cp -r . ~/.claude/plugins/repos/product-team
   ```

3. Restart Claude Code

## Usage

### Basic Workflow

1. **Create a Specification**
   ```
   /write-spec "Add user authentication feature"
   ```
   Creates `./tasks/user-auth/SPEC.md`

2. **Create Implementation Plan**
   ```
   /write-plan
   ```
   Creates `PLAN.md`, `TEST_PLAN.md`, and `COMMIT_MESSAGE.md`

3. **Implement the Feature**
   ```
   /write-code
   ```
   Implements according to the plan

4. **Finish the Task**
   ```
   /finish
   ```
   Archives task and syncs to GitHub

### With GitHub Issues

1. **Create GitHub Issue and Task**
   ```
   Use github-task-sync skill:
   ./skills/github-task-sync/create-issue.sh "Add authentication" "Implement magic link auth"
   ```
   Creates `tasks/123-add-authentication/`

2. **Work on the Task**
   Create SPEC.md, PLAN.md, etc. in the task directory

3. **Sync to GitHub**
   ```
   ./skills/github-task-sync/push.sh 123 ./tasks/123-add-authentication
   ```

## Layered Documentation

This plugin uses a **layered documentation system** for flexibility:

### Plugin Defaults (Global)
- `~/.claude/plugins/repos/product-team/docs/`
- Provides base processes that work across projects

### Project Overrides (Local)
- `.claude/docs/` (in your project)
- Allows project-specific customizations

**Lookup Order:**
1. Check `.claude/docs/[file].md` in project (if exists)
2. Fall back to `~/.claude/plugins/repos/product-team/docs/[file].md`

This means you can:
- Use the plugin's defaults out of the box
- Override or extend processes per-project as needed
- Keep project-specific rules in version control

## Process Documentation

The plugin includes comprehensive process docs in `docs/processes/`:

- **spec-rules.md**: How to write specifications
- **plan-rules.md**: How to create implementation plans
- **code-rules.md**: Coding standards and patterns
- **agent-rules.md**: Creating new specialized agents
- **process-manager-rules.md**: Process improvement guidelines

## Project-Specific Customization

### Extending Process Rules

Create `.claude/docs/processes/plan-rules.md` in your project:

```markdown
# Plan Rules (Project Extensions)

Include all base rules from the plugin, plus:

## Project-Specific Requirements

- Must use our monorepo structure (apps/, packages/)
- Reference our tech stack documentation
- Include security review phase
```

### Custom Standing Orders

Create `.claude/docs/standing-orders.md` in your project:

```markdown
# Standing Orders

Use plugin defaults, plus:

## Project-Specific

- Dev server logs: `./logs/dev.log`
- Run `pnpm lint` before completion
- Check Storybook stories build
```

## Agents Reference

| Agent | Purpose |
|-------|---------|
| spec-writer | Create specification documents |
| spec-checker | Validate specifications |
| plan-writer | Create implementation plans |
| plan-checker | Validate implementation plans |
| code-writer | Implement features |
| code-checker | Review code quality |
| documentation-manager | Maintain docs |
| engineering-manager | Oversee workflows |
| process-manager | Improve processes |
| agent-maker | Create new agents |
| browser-tester | Automated testing |

## Commands Reference

### Specification & Planning
- `/write-spec [topic]` - Create specification
- `/check-spec` - Validate specification
- `/write-plan` - Create implementation plan
- `/check-plan` - Validate plan

### Implementation
- `/write-code` - Implement according to plan
- `/check-code` - Review code quality

### Testing
- `/run-integration-tests` - Run test suite
- `/add-to-test-plan` - Add test scenarios

### Workflow
- `/agentic-spec-and-plan [topic]` - Full spec→plan workflow
- `/agentic-create-spec [topic]` - Automated spec creation
- `/agentic-create-plan` - Automated plan creation
- `/agentic-implement-plan` - Automated implementation
- `/finish` - Complete and archive task
- `/create-issue [title]` - Create GitHub issue

## Known Limitations

### Documentation Path References

Due to [Claude Code issue #9354](https://github.com/anthropics/claude-code/issues/9354), the `${CLAUDE_PLUGIN_ROOT}` environment variable doesn't work in markdown files (agents/commands).

**Current Workaround:**
We use hardcoded paths: `~/.claude/plugins/repos/product-team/`

**Future:**
When the bug is fixed, we'll update to: `${CLAUDE_PLUGIN_ROOT}/`

This doesn't affect functionality, just makes paths more explicit.

## Contributing

Contributions welcome! This plugin is designed to be extended and improved.

### Adding New Agents

Use the `agent-maker` agent:
```
Use agent-maker to create a new agent called "test-writer" that writes unit tests
```

### Improving Processes

Edit process docs in `docs/processes/` and submit a PR.

### Reporting Issues

Open an issue at: https://github.com/edspencer/claude-agents/issues

## License

MIT License - see LICENSE file for details

## Author

Ed Spencer

## Version History

### 0.1.0 (Initial Release)
- 15 specialized agents
- 19 slash commands
- github-task-sync skill
- Complete process documentation
- Layered configuration system
