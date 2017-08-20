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

printf 'Resetting [%s]\n' "$BRANCH_TO_MERGE_INTO" >&2
git remote add upstream "https://$GITHUB_SECRET_TOKEN@github.com/$GITHUB_REPO" >/dev/null 2>&1
git fetch upstream
git push upstream :$BRANCH_TO_MERGE_INTO >/dev/null 2>&1

printf 'Recreating [%s]\n' "$BRANCH_TO_MERGE_INTO" >&2
git checkout -b "$BRANCH_TO_MERGE_INTO"

printf 'Merging %s\n' "$TRAVIS_COMMIT" >&2
git merge --ff-only "$TRAVIS_COMMIT"

printf 'Cleaning up [%s] for release\n' "$BRANCH_TO_MERGE_INTO" >&2
git config user.name $GIT_COMMITTER_NAME >/dev/null 2>&1
git config user.email $GIT_COMMITTER_EMAIL >/dev/null 2>&1
git rm -rf scripts/ --ignore-unmatch
git rm -rf test/ --ignore-unmatch
git rm README.md --ignore-unmatch
git rm package.json --ignore-unmatch
git rm package-lock.json --ignore-unmatch
git rm .travis.yml --ignore-unmatch
git rm .gitignore --ignore-unmatch
uglifycss assets/css/style.css --output assets/css/style.min.css
git rm assets/css/style.css --ignore-unmatch
git add assets/css/style.min.css
minify-json assets/config/particles.json
git add assets/config/particles.json
html-minifier index.html --remove-comments --minify-js 1 --collapse-whitespace -o index.html
git add index.html
git commit -m "Clean up for build #$TRAVIS_BUILD_NUMBER to [$BRANCH_TO_MERGE_INTO]"

# Redirect to /dev/null to avoid secret leakage
printf 'Deploying to [%s]\n' "$BRANCH_TO_MERGE_INTO" >&2
git push -u upstream $BRANCH_TO_MERGE_INTO >/dev/null 2>&1
