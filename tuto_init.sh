#!/bin/bash

set -e

if git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Nope: You cannot use this script inside a Git repository!"
    exit 1
fi


echo "Cloning tutorial..."

git clone git@github.com:cryoxe/Tutorial-b4-p1.git tuto_git

echo "Download done."
echo "Preparing repository..."

cd tuto_git

git switch clue > /dev/null 2>&1
git switch main_feature > /dev/null 2>&1
git branch --remote -d 'origin/flag_2{branch_name}' > /dev/null 2>&1

git switch master > /dev/null 2>&1

echo "flag_7{stashing_is_great}" > secret_stash.txt
git add secret_stash.txt
git stash -m "Saving important file" > /dev/null 2>&1

echo "flag_8{just_in_time}" > to_delete.txt
git add to_delete.txt
git commit -m "Added temporary file" > /dev/null 2>&1
rm to_delete.txt

echo "flag_9{down_in_the_bunker}" > .git/SECRET

echo "Success!"
