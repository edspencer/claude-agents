#!/usr/bin/env python3
"""
Update all agent files to use the layered documentation lookup pattern.
"""

import re
from pathlib import Path

PLUGIN_PATH = "~/.claude/plugins/repos/software-dev-workflow"

# New documentation lookup section to add after frontmatter
DOC_LOOKUP_SECTION = """
## Documentation Lookup

**IMPORTANT: This plugin uses layered documentation.**

Before beginning work, check these documents in order:
1. **Standing Orders**: Check `.claude/docs/standing-orders.md` (project) OR `{plugin_path}/docs/standing-orders.md` (plugin)
2. **Process Rules**: Check `.claude/docs/processes/[relevant-process].md` (project) OR `{plugin_path}/docs/processes/[relevant-process].md` (plugin)

If both project and plugin versions exist, use the project version as it contains project-specific extensions or overrides.
""".format(plugin_path=PLUGIN_PATH)

def update_agent_file(file_path):
    """Update a single agent file with new documentation references."""
    with open(file_path, 'r') as f:
        content = f.read()

    # Remove old Standing Orders section if it exists
    content = re.sub(
        r'## Standing Orders\s+\*\*ALWAYS check.*?before beginning work\.\*\*[^\n]*\n\n',
        '',
        content,
        flags=re.DOTALL
    )

    # Replace absolute BragDoc paths with plugin paths
    content = content.replace(
        '/Users/ed/Code/brag-ai/.claude/docs',
        f'{PLUGIN_PATH}/docs'
    )

    # Update generic .claude/docs references to include both layers
    # But only for standing-orders specifically
    content = re.sub(
        r'`\.claude/docs/standing-orders\.md`',
        f'`.claude/docs/standing-orders.md` (project) OR `{PLUGIN_PATH}/docs/standing-orders.md` (plugin)',
        content
    )

    # Remove references to BragDoc-specific tech/ and user/ docs
    # These need to be genericized or removed
    content = re.sub(
        r'- \*\*Technical Documentation\*\*: Reference.*?`\.claude/docs/tech/`.*?\n',
        '- **Technical Documentation**: Reference your project\'s technical documentation\n',
        content
    )

    # Add the new Documentation Lookup section after frontmatter if not present
    if '## Documentation Lookup' not in content:
        # Find the end of frontmatter
        match = re.search(r'---\n\n(.+?)(?=##)', content, re.DOTALL)
        if match:
            # Insert after the intro paragraph but before first ## section
            intro_end = match.end(1)
            content = content[:intro_end] + "\n" + DOC_LOOKUP_SECTION + "\n" + content[intro_end:]

    with open(file_path, 'w') as f:
        f.write(content)

    print(f"Updated: {file_path.name}")

def main():
    agents_dir = Path(__file__).parent / 'agents'

    for agent_file in sorted(agents_dir.glob('*.md')):
        try:
            update_agent_file(agent_file)
        except Exception as e:
            print(f"Error updating {agent_file.name}: {e}")

    print("\nDone! Please review the changes.")
    print("Note: BragDoc-specific references (monorepo, tech docs, etc.) may need manual review.")

if __name__ == '__main__':
    main()
