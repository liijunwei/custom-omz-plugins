#!/bin/bash

function git-view-in-web() {
  local project_abs_path=$(git rev-parse --show-toplevel)

  local branch_or_commit_id=$1
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local branch_name=${branch_or_commit_id:-"$current_branch"}
  local real_branch=$(ud_convert_branchname $branch_name)

  local commit=$(git rev-parse $real_branch)
  local repo_http_url=$(get_repo_http_url)
  local repo_without_dot_git=$(dirname $repo_http_url)/$(basename $repo_http_url .git)
  local final_url="${repo_without_dot_git}/commit/${commit}"

  cat <<EOF

USAGE: git-view-in-web branch (flag)
-------------------------------------------------------------
cd \$HOME/OuterGitRepo/rails
git-view-in-web demobranch_123   # Show HEAD commit in browser, for code review.
git-view-in-web demobranch_123 x # Show branch \`demobranch_123\` info only, for link sharing.
-------------------------------------------------------------
${final_url};

EOF

  local open_in_web_tag=$2
  [[ -z "$open_in_web_tag" ]] && open $final_url;
}
