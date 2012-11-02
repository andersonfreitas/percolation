#!/bin/bash
# Update the gh-pages branch to include content from
# the gh-pages folder.

# Dependcies: `awk` and `git`, must be run on a Unix system.

cd "$(dirname $0)";

# the gh-pages branch
parent_sha=$(git show-ref -s refs/heads/gh-pages)

# get the sha from dist folder
doc_sha=$(git ls-tree -d HEAD dist | awk '{print $3}')

#
new_commit=$(echo "Auto-updating gh-pages." | git commit-tree $doc_sha -p $parent_sha)


git update-ref refs/heads/gh-pages $new_commit


exit;
