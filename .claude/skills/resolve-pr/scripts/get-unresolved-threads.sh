#!/bin/bash
# get-unresolved-threads.sh
# Fetch unresolved PR review threads via GraphQL
# Usage: ./get-unresolved-threads.sh <owner> <repo> <pr_number>

set -e

OWNER="$1"
REPO="$2"
PR_NUMBER="$3"

if [ -z "$OWNER" ] || [ -z "$REPO" ] || [ -z "$PR_NUMBER" ]; then
  echo "Usage: $0 <owner> <repo> <pr_number>" >&2
  exit 1
fi

gh api graphql -f query='
query($owner: String!, $repo: String!, $number: Int!) {
  repository(owner: $owner, name: $repo) {
    pullRequest(number: $number) {
      id
      url
      reviewThreads(first: 100) {
        nodes {
          id
          isResolved
          path
          line
          comments(first: 10) {
            nodes {
              id
              databaseId
              body
              author { login }
            }
          }
        }
      }
    }
  }
}' -F owner="$OWNER" -F repo="$REPO" -F number="$PR_NUMBER" | jq '
  .data.repository.pullRequest.reviewThreads.nodes
  | map(select(.isResolved == false))
  | map({
      threadId: .id,
      path: .path,
      line: .line,
      comments: .comments.nodes | map({
        id: .id,
        databaseId: .databaseId,
        body: .body,
        author: .author.login
      })
    })
'
