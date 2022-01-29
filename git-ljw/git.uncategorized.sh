#!/bin/bash

function git-make-rollback() {
  local rollback_branch_name="$(date "+rollback-%Y%m%d-%H%M")"
  git checkout -b ${rollback_branch_name}
  local current_branch=$(git rev-parse --abbrev-ref HEAD)

  echo "Rollback Branch Name: ${rollback_branch_name}"
  echo "Current Branch Name: ${current_branch}"
  echo "====================================="

  git push --set-upstream origin ${current_branch}
  git status
}

function git-tag-stable() {
  local tag_name="stable-$(date "+%Y%m%d")"
  echo "============================"
  echo "Tag Created: ${tag_name}"
  echo "Command to delete this tag: git tag -d ${tag_name}"

  git tag ${tag_name}
}

function ud_convert_branchname(){
  local raw_branchname=$1;
  echo $raw_branchname | tr '-' '_' | tr "[:upper:]" "[:lower:]";
}

unalias gco
function gco() {
  local original_branch_name=$1;
  local branch_name=$(ud_convert_branchname $original_branch_name);
  git checkout $([[ $branch_name == origin/* || $branch_name == remotes/origin/* ]] && echo "$branch_name" | tr  '/' ' ' | awk '{print $NF}' || echo $branch_name);

  result=$?
  if [ "$result" != "0" ]; then
    echo "--------------------------------------";
    echo "using original: $original_branch_name";
    git checkout $original_branch_name;
  fi

  git log | head -n1;
}

unalias gst
function gst() {
  git status 2> /dev/null

  if [ $? -eq 128 ]; then
    echo "Current directory is not a git repository."
    return 0;
  fi

  echo

  local commit_id=$(git rev-parse HEAD)
  local commit_msg=$(get-commit-message-by-commit-id $commit_id)
  echo "head commit id"
  echo "========================================"
  echo "$commit_id"
  echo
  echo "head commit msg"
  echo "========================================"
  echo "$commit_msg"
  echo
}

# It's hard to implemented by alias
# git checkout -b xxx && git push --set-upstream origin xxx
function gcobp() {
  if [ $# -eq 0 ]; then
    echo "Usage: checkout new branch and push to origin."
    return 0;
  fi

  local branch_name=$(ud_convert_branchname $1);
  git checkout -b $branch_name;
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD);
}

function get-commit-message-by-commit-id() {
  local commit_id=$1
  git log --format=%B -n 1 $commit_id | cat
}

# Get first N commit ids, for cherry-pick use
function get-0-to-N-commits() {
  local commit_id=$1
  echo "找出 $(git rev-parse --abbrev-ref HEAD) 分支最新的 (0..$commit_id) commits"

  for i in {0..$commit_id}; do
    local commit_id=$(git rev-parse  HEAD~$i)
    echo "git cherry-pick $commit_id ; # 第 $i 个 $(get-commit-message-by-commit-id $commit_id)";
  done
}

function git-show-commit-files() {
  local commit_id=$1

  if [ -z "${commit_id}" ]; then
    local commit_id=$(git rev-parse --abbrev-ref HEAD)
  fi

  git show --pretty="" --name-only $commit_id | cat
}

function ccc() {
  local commit_msg=$1
  local default_msg="Code cleanup"

  git add .

  if [ -z "${commit_msg}" ]; then
    git commit -m "$default_msg."
    git push;
    return 0;
  fi

  git commit -m "$default_msg: $commit_msg."
  git push
}

