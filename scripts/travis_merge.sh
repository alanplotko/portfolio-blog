#!/bin/bash -e

: "${BRANCHES_TO_MERGE_REGEX?}" "${BRANCH_TO_MERGE_INTO?}"
: "${GITHUB_SECRET_TOKEN?}" "${GITHUB_REPO?}"

export GIT_COMMITTER_EMAIL=${GIT_COMMITTER_EMAIL}
export GIT_COMMITTER_NAME=${GIT_COMMITTER_NAME}

if ! grep -q "$BRANCHES_TO_MERGE_REGEX" <<< "$TRAVIS_BRANCH"; then
    printf "Current branch %s doesn't match regex %s, exiting\\n" \
        "$TRAVIS_BRANCH" "$BRANCHES_TO_MERGE_REGEX" >&2
    exit 0
fi

# Since Travis does a partial checkout, we need to get the whole thing
repo_temp=$(mktemp -d)
git clone "https://github.com/$GITHUB_REPO" "$repo_temp"

# shellcheck disable=SC2164
cd "$repo_temp"

printf 'Checking out %s\n' "$BRANCH_TO_MERGE_INTO" >&2
git checkout "$BRANCH_TO_MERGE_INTO"

printf 'Merging %s\n' "$TRAVIS_COMMIT" >&2
git merge --ff-only "$TRAVIS_COMMIT"

printf 'Cleaning up for release\n' >&2
git rm -rf scripts/
git rm -rf test/
git rm package.json
git rm package-lock.json
minify --output assets/css/style.min.css assets/css/style.css
git rm assets/css/style.css
git add assets/css/style.min.css
html-minifier index.html --remove-comments --minify-js 1 --collapse-whitespace -o index.html
git add index.html
git commit -m "Clean up for build #$TRAVIS_BUILD_NUMBER to stage"

printf 'Pushing to %s\n' "$GITHUB_REPO" >&2

push_uri="https://$GITHUB_SECRET_TOKEN@github.com/$GITHUB_REPO"

# Redirect to /dev/null to avoid secret leakage
- git push "https://$GITHUB_SECRET_TOKEN@github.com/$GITHUB_REPO" \
-    "$BRANCH_TO_MERGE_INTO" >/dev/null 2>&1
