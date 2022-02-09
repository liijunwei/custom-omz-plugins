#!/bin/bash
function goto_or_goto_and_clone() {
  local target_dir=$1
  cd "$target_dir"

  local git_repo_url=$2
  if [[ "" == "$git_repo_url" ]]; then
    return 0
  else
    gcll "$git_repo_url"
    return 0
  fi
}

function out() {
  local repo_url=$1
  goto_or_goto_and_clone "$HOME/OuterGitRepo" "$repo_url"
}

function up() {
  local repo_url=$1
  goto_or_goto_and_clone "$HOME/Udesk/02UdeskProject" "$repo_url"
}
