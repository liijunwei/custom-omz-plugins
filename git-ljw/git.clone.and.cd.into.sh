#!/bin/bash

function gcll() {
  local remote_repo_name=$1
  local local_repo_dir_with_dot_git=${remote_repo_name:t}    # 取最后一部分
  local local_repo_dir=${local_repo_dir_with_dot_git%".git"} # 去除最后的 .git

  git clone ${remote_repo_name}
  cd ${local_repo_dir}
  pwd
  echo "=========================================="
  git status
}
