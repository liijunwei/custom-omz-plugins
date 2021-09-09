#!/bin/bash

function git-view-in-web() {
  local project_abs_path=$(git rev-parse --show-toplevel);
  local project_name=${project_abs_path:t};

  local branch_or_commit_id=$1;
  local current_branch=$(git rev-parse --abbrev-ref HEAD)
  local real_branch=${branch_or_commit_id:-"$current_branch"}
  local commit=$(git rev-parse $real_branch);

  local repo_http_url=$(get_repo_http_url)

  if [[ "$repo_http_url" == *"$UDESK_DEV_DOMAIN"* ]]; then
    local repo_without_dot_git=$(get_repo_http_url | grep -Eo ".*com/udesk")
    local url="${repo_without_dot_git}/${project_name}/commit/${commit}"
  else
    # github
    local repo_with_dot_git=$(get_repo_http_url)
    local repo_without_dot_git=${repo_with_dot_git%".git"}
    local url="${repo_without_dot_git}/commit/${commit}"
  fi

  cat <<EOF

USAGE: git-view-in-web branch (flag)
-------------------------------------------------------------
cd $HOME/OuterGitRepo/rails
git-view-in-web demobranch_123   # Show HEAD commit in browser, for code review.
git-view-in-web demobranch_123 x # Show branch \`demobranch_123\` info only, for link sharing.
-------------------------------------------------------------
${url};

EOF

  local open_in_web_tag=$2
  [[ -z "$open_in_web_tag" ]] && open $url;
}
