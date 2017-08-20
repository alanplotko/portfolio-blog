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

#########################
# Set up stage
#########################

printf 'Setting up [%s]\n' "$BRANCH_TO_MERGE_INTO" >&2
git checkout -b "$BRANCH_TO_MERGE_INTO" "$TRAVIS_COMMIT"

#########################
# Clean up stage
#########################

printf 'Cleaning up [%s] for release\n' "$BRANCH_TO_MERGE_INTO" >&2

# Set up git config
git config user.name $GIT_COMMITTER_NAME >/dev/null 2>&1
git config user.email $GIT_COMMITTER_EMAIL >/dev/null 2>&1

# Remove unneeded files for stage
git rm -rf scripts/ --ignore-unmatch
git rm -rf test/ --ignore-unmatch
git rm README.md --ignore-unmatch
git rm package.json --ignore-unmatch
git rm package-lock.json --ignore-unmatch
git rm .travis.yml --ignore-unmatch
git rm .gitignore --ignore-unmatch

# Minify style.css
uglifycss assets/css/style.css --output assets/css/style.min.css
git rm assets/css/style.css --ignore-unmatch
git add assets/css/style.min.css

# Minify index.html
html-minifier index.html --remove-comments --minify-js 1 --collapse-whitespace -o index.html
git add index.html

# Minify particles.js
uglifyjs --compress --mangle -o assets/js/particles.min.js -- assets/js/particles.js
git rm assets/js/particles.js --ignore-unmatch
git add assets/js/particles.min.js

# Commit changes
git commit -m "Clean up for build #$TRAVIS_BUILD_NUMBER to [$BRANCH_TO_MERGE_INTO]"

#########################
# Deploy stage
#########################

# Redirect to /dev/null to avoid secret leakage
printf 'Deploying [%s]\n' "$BRANCH_TO_MERGE_INTO" >&2
git push "https://$GITHUB_SECRET_TOKEN@github.com/$GITHUB_REPO" \
  "$BRANCH_TO_MERGE_INTO" >/dev/null 2>&1
