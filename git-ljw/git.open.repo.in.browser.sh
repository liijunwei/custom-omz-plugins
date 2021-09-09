#!/bin/bash

function get_repo_http_url(){
  local remote_url=$(git remote get-url --push origin)
  local url=$(
    echo $remote_url      |
    cut -d '@' -f 2       |
    sed 's/:9876//'       |
    sed 's/^https:\/\///' |
    sed 's/com:/com\//'
  )

  echo "http://${url}"
}

function or(){
  local url=$(get_repo_http_url)

  cat <<EOF

USAGE: Open Repo in Github/Gitlab
-------------------------------------------------------------
cd $HOME/OuterGitRepo/whenever
or   # Open url from browser, and show info.
or x # Do not open url, just show info.
-------------------------------------------------------------
${url}

EOF

  [[ -z "$1" ]] && open $url; # for macos use `open`
                              # for linux, use `xdg-open`
}
