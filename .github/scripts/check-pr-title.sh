#!/usr/bin/env bash
# Checks that a PR title follows Conventional Commits, e.g. `feat(telescope): add buffer picker`.
# Usage: check-pr-title.sh "<title>". Used by the PR Title workflow.
set -euo pipefail

title="$1"
types="feat|fix|docs|style|refactor|perf|test|build|ci|chore|revert"
pattern="^($types)(\([a-z0-9./-]+\))?!?: [^ ].*[^.]$"

if [[ "$title" =~ $pattern ]]; then
  echo "PR title follows Conventional Commits: $title"
  exit 0
fi

echo "::error title=Invalid PR title::'$title' must look like 'type(scope): summary'"
{
  echo "### PR title doesn't follow Conventional Commits"
  echo
  echo "Got: \`$title\`"
  echo
  echo "Expected \`type(optional-scope): summary\`, with a lowercase imperative summary and no"
  echo "trailing period. Allowed types: \`${types//|/\`, \`}\`."
  echo
  echo "Examples: \`feat(telescope): add buffer picker\`, \`fix(lsp): attach keymaps on Windows\`,"
  echo "\`chore(deps): update lazy-lock.json\`. Append \`!\` before the colon for breaking changes."
} >> "${GITHUB_STEP_SUMMARY:-/dev/null}"
exit 1
