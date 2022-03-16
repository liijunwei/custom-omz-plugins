#!/bin/bash

function gcll() {
  local repo_url=$1
  local repo_dir=$(basename $repo_url .git)

  git clone $repo_url
  cd $repo_dir
  pwd
  echo "=========================================="
  git status
}
