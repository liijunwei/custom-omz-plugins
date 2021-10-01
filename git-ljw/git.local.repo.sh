#!/bin/bash

# TODO 不要泄露这么多无用的function

function do_trim_remote_info(){
  local info="$1"
  echo $info | sed 's/origin//' | sed 's/fetch//'  | sed 's/push//' | sed 's/()//'
}

function git_remote_backup_file(){
  echo "${_git_ljw_path}/git.local.repo.remote.backup"
}

function do_log_rollback_info(){
  git remote -vv >> /dev/null

  if [[ "$?" != 0 ]]; then
    echo "No need to backup"
    return 1
  fi

  local file=$(git_remote_backup_file)
  echo "Backup current remote config"
  echo "------------------------"
  git remote -vv
  date >> "$_git_ljw_path/git.local.repo.remote.backup"
  git remote -vv >> "$_git_ljw_path/git.local.repo.remote.backup"
  echo

  echo "Backup file:"
  echo "------------------------"
  echo "$file"
  echo
  do_print_rollback_info "$file"
}

function do_print_rollback_info(){
  local file=$1

  echo "Rollback method:"
  echo "------------------------"
  local rollback_origin_push=$(do_trim_remote_info "$(tail -n1 $file)")
  cat << EOF
git remote remove origin
git remote add origin $rollback_origin_push
EOF
}

function do_setup_local_repo(){
  local local_repo_dir="$HOME/local.repo"
  cd $local_repo_dir

  local local_repo_name="$1"
  git init --bare "${local_repo_name}.git" >> $(git_remote_backup_file)

  echo "Local Repo"
  echo "------------------------"
  echo "$local_repo_dir/${local_repo_name}.git"
}

function do_rollback(){
  local info="$1"
  echo $info | sed 's/origin//' | sed 's/fetch//'  | sed 's/push//' | sed 's/()//'
}

# TODO
#
# 1. make dir in $HOME/local.repo
# 2. unset current repo's origin
# 3. set local_repo as current repo's origin(`git remote add origin file://$HOME/local.repo/demo.git`)
# 4. push
function git-push-local-repo() {
  local local_repo_name=$1
  if [[ "" == "$local_repo_name" ]]; then
    local local_repo_name="tmp_$(date "+%Y%m%d%H%M%S")"
  fi

  do_log_rollback_info
  echo
  do_setup_local_repo "$local_repo_name"
  echo "Hi from git-push-local-repo..."
}
