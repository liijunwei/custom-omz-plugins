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

unalias gco
function gco() {
  local original_branch_name=$1;
  local branch_name=$(echo $original_branch_name | tr '-' '_' | tr "[:upper:]" "[:lower:]");
  git checkout $branch_name;

  result=$?
  if [ "$result" != "0" ]; then
    echo "--------------------------------------";
    echo "using original: $original_branch_name";
    git checkout $original_branch_name;
  fi

  git log | head -n1;
}

# 使用别名不好实现
# git checkout -b xxx && git push to origin
function gcobp() {
  if [ $# -eq 0 ]; then
    echo "作用: checkout一个新分支, 并且推送到远端仓库."
    return 1;
  fi

  local branch_name=$(echo $1 | tr '-' '_' | tr "[:upper:]" "[:lower:]")
  git checkout -b $branch_name;
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD);
}

function get-commit-message-by-commit-id() {
  local commit_id=$1
  git log --format=%B -n 1 $commit_id | cat
}

# 获取前N个commit的commit号, 用于cherry-pick
function get-0-to-N-commits() {
  local commit_num=$1
  echo "找出 $(git rev-parse --abbrev-ref HEAD) 分支最新的 (0..$commit_num) commits"

  for i in {0..$commit_num}; do
    local commit_id=$(git rev-parse  HEAD~$i)
    echo "git cherry-pick $commit_id ; # 第 $i 个 $(get-commit-message-by-commit-id $commit_id)";
  done
}

function git-show-commit-files() {
  local commit_num=$1

  if [ -z "${commit_num}" ]; then
    local commit_num=$(git rev-parse --abbrev-ref HEAD)
  fi

  git show --pretty="" --name-only $commit_num | cat
}

