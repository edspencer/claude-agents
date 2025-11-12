#!/bin/bash

# Script to update all documentation paths to use layered lookup pattern
# Plugin paths: ~/.claude/plugins/repos/software-dev-workflow/docs/...
# Project override paths: .claude/docs/...

PLUGIN_PATH="~/.claude/plugins/repos/software-dev-workflow"

cd "$(dirname "$0")"

echo "Updating documentation paths in agents, commands, and skills..."

# Function to update standing-orders references
update_standing_orders() {
  find agents commands -type f -name "*.md" -exec sed -i '' \
    "s|\*\*ALWAYS check \`\.claude/docs/standing-orders\.md\` before beginning work\.\*\*|\*\*ALWAYS check \`.claude/docs/standing-orders.md\` (project) or \`$PLUGIN_PATH/docs/standing-orders.md\` (plugin) before beginning work.\*\*|g" {} \;
}

# Function to replace absolute BragDoc paths with plugin paths
update_absolute_paths() {
  find agents commands -type f -name "*.md" -exec sed -i '' \
    "s|/Users/ed/Code/brag-ai/\.claude/docs|$PLUGIN_PATH/docs|g" {} \;
}

# Function to update process document references
update_process_docs() {
  find agents commands -type f -name "*.md" -exec sed -i '' \
    "s|\`\.claude/docs/processes/\([^']*\)\.md\`|\`.claude/docs/processes/\1.md\` (project) or \`$PLUGIN_PATH/docs/processes/\1.md\` (plugin)|g" {} \;
}

# Function to update tech/user doc references (remove these as they're BragDoc-specific)
remove_bragdoc_specific() {
  # These will be handled on a case-by-case basis
  echo "Note: BragDoc-specific tech/ and user/ doc references need manual review"
}

echo "1. Updating standing-orders references..."
update_standing_orders

echo "2. Updating absolute BragDoc paths..."
update_absolute_paths

echo "3. Updating process document references..."
update_process_docs

echo "Done! Please review the changes and handle BragDoc-specific references manually."
