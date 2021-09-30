#!/bin/bash

# TODO
#
# 1. make dir in $HOME/local.repo
# 2. unset current repo's origin
# 3. set local_repo as current repo's origin(`git remote add origin file://$HOME/local.repo/demo.git`)
# 4. push
function git-push-local-repo() {
  echo "current remote config:"
  echo "------------------------"
  git remote -vv
  echo
  echo "Rollback method:"
  echo "------------------------"
  echo "This is how I Rollback..."

  echo
  echo "Hi from git-push-local-repo..."
}
