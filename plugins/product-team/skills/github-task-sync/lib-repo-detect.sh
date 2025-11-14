#!/bin/bash

# Shared library for detecting GitHub repository from git remote
# Usage: source this file and call detect_github_repo

# Extracts owner and repo from a GitHub URL
# Supports both HTTPS and SSH formats:
#   https://github.com/owner/repo.git
#   git@github.com:owner/repo.git
extract_repo_from_url() {
  local url="$1"

  # Remove .git suffix if present
  url="${url%.git}"

  # Handle HTTPS format: https://github.com/owner/repo
  if [[ $url =~ https://github\.com/([^/]+)/([^/]+) ]]; then
    echo "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
    return 0
  fi

  # Handle SSH format: git@github.com:owner/repo
  if [[ $url =~ git@github\.com:([^/]+)/(.+) ]]; then
    echo "${BASH_REMATCH[1]}/${BASH_REMATCH[2]}"
    return 0
  fi

  return 1
}

# Detects GitHub repository from environment or git remote
# Sets REPO_OWNER and REPO_NAME global variables
# Returns 0 on success, 1 on failure
detect_github_repo() {
  # Method 1: Use environment variables if set
  if [ -n "${GITHUB_OWNER:-}" ] && [ -n "${GITHUB_REPO:-}" ]; then
    REPO_OWNER="$GITHUB_OWNER"
    REPO_NAME="$GITHUB_REPO"
    return 0
  fi

  # Method 2: Extract from git remote
  if ! command -v git &> /dev/null; then
    echo "Error: git command not found" >&2
    return 1
  fi

  # Check if we're in a git repository
  if ! git rev-parse --git-dir &> /dev/null; then
    echo "Error: Not in a git repository" >&2
    echo "Please run this command from within a git repository, or set GITHUB_OWNER and GITHUB_REPO environment variables" >&2
    return 1
  fi

  # Get the origin remote URL
  local remote_url
  remote_url=$(git config --get remote.origin.url 2>/dev/null)

  if [ -z "$remote_url" ]; then
    echo "Error: No 'origin' remote found in git repository" >&2
    echo "Please add a GitHub remote or set GITHUB_OWNER and GITHUB_REPO environment variables" >&2
    return 1
  fi

  # Extract owner/repo from URL
  local repo_full
  repo_full=$(extract_repo_from_url "$remote_url")

  if [ -z "$repo_full" ]; then
    echo "Error: Could not extract GitHub repository from remote URL: $remote_url" >&2
    echo "Please ensure the remote is a GitHub URL, or set GITHUB_OWNER and GITHUB_REPO environment variables" >&2
    return 1
  fi

  # Split into owner and repo
  REPO_OWNER="${repo_full%%/*}"
  REPO_NAME="${repo_full#*/}"

  # Validate we got both parts
  if [ -z "$REPO_OWNER" ] || [ -z "$REPO_NAME" ]; then
    echo "Error: Failed to parse repository owner and name from: $repo_full" >&2
    return 1
  fi

  return 0
}
