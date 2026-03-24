#!/bin/sh

if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    echo "Nope: You need to use this script inside the Intranet repository"
    exit 1
fi

path=${PWD##*/}
if [ $path != "Git_Advanced" ]; then
    echo "Nope: You need to run this script from the Git_Advanced repository"
    exit 1
fi

name=$(git config user.name)
email=$(git config user.email)

if [ -z "$name" ] || [ -z "$email" ]; then
    echo "Make sure to setup your git identity using these commands:"
    echo -e "\tgit config user.name \"Your Name\""
    echo -e "\tgit config user.email \"example@email.com\""
    exit 1
fi


git config user.name "Sonny Resetti" 1>/dev/null
git config user.email "sonny.resetti@acdc.fr" 1>/dev/null

echo "Starting reset..."
if ! git rev-parse --verify master >/dev/null 2>&1; then
    git branch master
fi
git switch master 1>/dev/null

cp investigation_report.txt     /tmp/investigation_report.txt
cp tutorial_answer.txt          /tmp/tutorial_answer.txt

rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch master" --allow-empty 1>/dev/null

if ! git rev-parse --verify merge_simple >/dev/null 2>&1; then
    git branch merge_simple
fi
git switch merge_simple 1>/dev/null
rm -rf *
git add . 1>/dev/null 
git commit -m "Resetting branch merge_simple" --allow-empty 1>/dev/null

if ! git rev-parse --verify merge_me >/dev/null 2>&1; then
    git branch merge_me
fi
git switch merge_me 1>/dev/null
rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch merge_me" --allow-empty 1>/dev/null

if ! git rev-parse --verify merge_conflict_1 >/dev/null 2>&1; then
    git branch merge_conflict_1
fi
git switch merge_conflict_1 1>/dev/null
rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch merge_conflict_1" --allow-empty 1>/dev/null

if ! git rev-parse --verify hello_world_impl >/dev/null 2>&1; then
    git branch hello_world_impl
fi
git switch hello_world_impl 1>/dev/null
rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch hello_world_impl" 1>/dev/null


if ! git rev-parse --verify merge_conflict_2 >/dev/null 2>&1; then
    git branch merge_conflict_2
fi
git switch merge_conflict_2 1>/dev/null
rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch merge_conflict_2" 1>/dev/null

if ! git rev-parse --verify add_stack_impl >/dev/null 2>&1; then
    git branch add_stack_impl
fi
git switch add_stack_impl 1>/dev/null
rm -rf *
git add . 1>/dev/null
git commit -m "Resetting branch add_stack_impl" 1>/dev/null

git switch master 1>/dev/null

cp /tmp/investigation_report.txt     investigation_report.txt
cp /tmp/tutorial_answer.txt          tutorial_answer.txt
mkdir -p $PWD
git add investigation_report.txt tutorial_answer.txt 1>/dev/null
git commit -m "Restored flag files" 1>/dev/null

git config user.name "$name"
git config user.email "$email"

echo "All cleaned up! Now you can re-init the repository"