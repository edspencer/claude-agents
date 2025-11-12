# Standing Orders

Cross-cutting concerns that apply to all agents. **ALWAYS check this document before beginning work.**

NOTE: There is an issue with ${CLAUDE_PLUGIN_ROOT} that prevents the plugin from working correctly. See https://github.com/anthropics/claude-code/issues/9354 for details.

## Development Environment

### Testing Requirements

**ALWAYS run tests before marking tasks complete:**

```bash
# Run all tests (adjust command for your project)
npm test
# OR
pnpm test
# OR
yarn test

# Build to verify no errors
npm run build
```

- Run tests after code changes
- Fix any failing tests before completion
- Add tests for new functionality
- Verify build succeeds without errors

## Documentation Maintenance

### Update Documentation After Code Changes

**ALWAYS update relevant documentation when implementing changes:**

- **Technical docs** (`.claude/docs/tech/` or project equivalent): Update when architecture, patterns, or conventions change
- **User docs** (`.claude/docs/user/` or project equivalent): Update when user-facing features change
- **CLAUDE.md**: Update when project structure or conventions change
- **Process docs** (`.claude/docs/processes/`): Update when development processes change

### GitHub Task Sync

**Keep GitHub issues synchronized with local task work:**

- **Source of truth**: GitHub issues are the authoritative source for task documentation
- **Local cache**: Task files in `./tasks/` are working copies for agents to edit
- **Sync workflow**: Use the `github-task-sync` skill to push/pull task files (SPEC.md, PLAN.md, TEST_PLAN.md, COMMIT_MESSAGE.md)
- **When to sync**:
  - Pull from GitHub before starting work on a task
  - Push after major updates (spec validation, plan validation, implementation completion)
  - Final sync via `/finish` SlashCommand before archiving

**Reference:** See the github-task-sync skill documentation for complete details.

### Cross-Reference Validation

When updating files, check for cross-references that may need updating:

```bash
# Search for references to file/feature you're changing
grep -r "feature-name" .claude/
```

## Context Window Management

### When to Delegate vs. Handle Directly

**Delegate when:**
- Task requires specialized agent expertise (use spec-writer for specs, plan-writer for plans, etc.)
- Context window is getting full (>75% of budget)
- Task is large and can be broken into subtasks
- Multiple independent subtasks can be parallelized

**Handle directly when:**
- Task is simple and within your expertise
- Delegation overhead exceeds direct implementation cost
- Context is already loaded (files read, patterns understood)
- Quick iteration is needed

### Context Window Strategies

1. **Read files strategically:** Only read files you need, use Grep/Glob first to find relevant files
2. **Use incremental approach:** Complete one subtask fully before moving to next
3. **Delegate large tasks:** Break into phases and delegate to fresh agents
4. **Reference previous work:** Link to existing documentation instead of re-reading

## Error Handling and Recovery

### Error Response Pattern

When encountering errors:

1. **Analyze root cause:** Don't just treat symptoms, understand the underlying issue
2. **Check patterns:** Review existing code for similar patterns and solutions
3. **Verify fix:** Test thoroughly after fixing
4. **Document resolution:** Record solution for future reference if appropriate

### Common Error Categories

- **Type errors:** Check types, imports, and interfaces
- **Build errors:** Check build configuration, dependencies, and build settings
- **Runtime errors:** Check server/dev logs, browser console, and API responses
- **Test errors:** Check test setup, mocks, and assertions

### Recovery Steps

If blocked:
1. Document the blocker
2. Try alternative approaches based on codebase patterns
3. Search for similar issues in codebase/docs
4. Ask user for guidance if truly blocked
5. Never skip tasks without explicit instruction

## Quality Assurance

### Pre-Completion Checklist

Before marking any task complete:

- [ ] Type checking: No type errors (build succeeds)
- [ ] Tests: All tests pass
- [ ] Patterns: Code matches existing codebase patterns
- [ ] Security: Follow security best practices for the project
- [ ] Documentation: Relevant docs updated
- [ ] Verification: Manually verified functionality works

### Code Quality Standards

- Follow patterns in CLAUDE.md and project technical documentation
- Match existing code style
- Add inline comments for complex logic
- Use descriptive variable/function names
- Keep functions focused and single-purpose

## Communication

### User Communication

- Be concise but thorough
- Explain complex decisions and trade-offs
- Proactively identify potential issues
- Ask for clarification when ambiguous
- Provide actionable recommendations

## File Operations

### Path Usage

- **Always use absolute paths** in agent threads (cwd can reset between bash calls)
- Check parent directory exists before creating files/directories
- Use proper error handling for file operations

---

## Summary

These standing orders ensure consistent, high-quality work across all agents:

1. **Run tests** - Verify quality before completion
2. **Update docs** - Keep documentation current
3. **Manage context** - Delegate when appropriate
4. **Handle errors properly** - Document and resolve systematically
5. **Maintain quality** - Follow checklist before marking complete
6. **Communicate clearly** - Keep user informed

## Project-Specific Customization

**Note:** This is the plugin's default standing-orders.md. Projects can create their own version at `.claude/docs/standing-orders.md` with project-specific additions or overrides such as:

- Specific dev server log locations
- Custom test commands or requirements
- Project-specific file organization rules
- Security requirements specific to the project
- Additional quality checks
