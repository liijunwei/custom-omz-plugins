#!/bin/bash

# TODO 不要泄露这么多无用的function

function _do_trim_remote_info(){
  local info="$1"
  echo $info | sed 's/origin//' | sed 's/fetch//'  | sed 's/push//' | sed 's/()//'
}

function _git_remote_backup_file(){
  echo "${_git_ljw_path}/git.local.repo.remote.backup"
}

function _do_log_rollback_info(){
  git remote -vv >> /dev/null

  if [[ "$?" != 0 ]]; then
    echo "No need to backup"
    return 1
  fi

  local file=$(_git_remote_backup_file)
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
  _do_print_rollback_info "$file"
}

function _do_print_rollback_info(){
  local file=$1

  echo "Rollback method:"
  echo "------------------------"
  local rollback_origin_push=$(_do_trim_remote_info "$(tail -n1 $file)")
  cat << EOF
git remote remove origin
git remote add origin $rollback_origin_push
EOF
}

function _do_setup_local_repo(){
  local local_repo_dir="$HOME/local.repo"
  cd $local_repo_dir

  local local_repo_name="$1"
  git init --bare "${local_repo_name}.git" >> $(_git_remote_backup_file)

  echo "$local_repo_dir/${local_repo_name}.git"
}

function _do_setup_remote(){
  local repo="$1"
  git remote add origin "file://$repo"
  git push --set-upstream origin $(git rev-parse --abbrev-ref HEAD)
  echo
  git remote -vv
  echo
}

# TODO
function do_rollback(){
  local info="$1"
  echo $info | sed 's/origin//' | sed 's/fetch//'  | sed 's/push//' | sed 's/()//'
}

# TODO unset all other functions
function git-push-local-repo() {
  local local_repo_name=$1
  if [[ "" == "$local_repo_name" ]]; then
    local local_repo_name="tmp_$(date "+%Y%m%d%H%M%S")"
  fi

  _do_log_rollback_info

  local local_repo=$(_do_setup_local_repo "$local_repo_name")
  _do_setup_remote "$local_repo"
}
