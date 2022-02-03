#!/bin/bash

# grep keyword in all commits from current project
# prerequisite: https://github.com/junegunn/fzf
function git-grep-commits() {
  local keyword=$1
  git log -S "$keyword" --source --all | fzf
}
