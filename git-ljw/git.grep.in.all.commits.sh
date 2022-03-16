#!/bin/bash

# grep keyword in all commits from current project
function git-grep-commits() {
  local keyword=$1
  git log -S "$keyword" --source --all | cat
}
